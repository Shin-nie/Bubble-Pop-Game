//
//  GameViewModel.swift - INITIALISED OBJECT'S INSTANCES in list [ MODEL VIEW ]
//                      - & OBJECT'S FUNCTION [ MODEL VIEW ]
//  BubblePopGame
//
// Manages the game state, including the timer, score calculation, and bubble generation based on the probabilities.
// manages the game's data and logic ( generating bubbles, keeping track of the score, and the game timer )
// - MANAGES the game logic, including tracking time and bubbles.

import Foundation
import UIKit
import SwiftUI
import Combine

//  MANAGES the game, keeping track of time and bubbles.
//  USED for TIMER SETTING
class GameViewModel: ObservableObject { //  CLASS S.
    
    @Published var gameTimeLeft: Int        //  CONTROL the TIME LIMIT
    var maxBubbles: Int                     //  CONTROL the maximum number of bubbles
    @Published var bubbles: [Bubble] = []   //  ARRAY of Bubble Models
    
    //  INITIALIZER BUBBLES
    let bubbleTypes: [Bubble] = [
        Bubble(position: .zero, color: .red, colorName: "red", points: 1, probability: 0.4), //40%
        Bubble(position: .zero, color: pink, colorName: "pink", points: 2, probability: 0.3),
        Bubble(position: .zero, color: .green, colorName: "green", points: 5, probability: 0.15),
        Bubble(position: .zero, color: .blue, colorName: "blue", points: 8, probability: 0.1),
        Bubble(position: .zero, color: .black, colorName: "black", points: 10, probability: 0.05)
    ]
    
    //  HANDLE SCORE
    @Published var currentScore: Int = 0
    
    private var lastPoppedColor: String? = nil
    
    var highScoreViewModel: HighScoreViewModel
    
    //  CREATE REPEATING AUTOMATICALLY TIMER - emits bubbles every 1.0 seconds
    //  ALL UPDATES SHOULD BE HAPPEND ON THE .main
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    //  INITIALISE the GAMEMODEL with a specific game time & number of bubbles
    //  SET UP Game - HOW LONG the game should last (70 seconds)
    //  WANT TO PASS VALUE - INITIALISE Instances - not Default Value Int = 70
    init(gameTimeLeft: Int, maxBubbles: Int, highScoreViewModel: HighScoreViewModel) {
        self.gameTimeLeft = gameTimeLeft
        self.maxBubbles = maxBubbles
        self.highScoreViewModel = highScoreViewModel
    }
    
    //  DECREMENT TIMER
    func countDown() {
        if gameTimeLeft > 0 {
            gameTimeLeft -= 1
            generateBubbles()
        }
    }
    
    //  MARK: BUBBLES FUNCTION
    //  POP BUBBLES when TAPPED
    func popBubble(_ bubble: Bubble) {
        
        if let index = bubbles.firstIndex(where: { $0.id == bubble.id && !$0.popped }) {
            bubbles[index].popped = true  // Mark the bubble as popped
            updateScore(for: bubbles[index])
            objectWillChange.send()  // Notify views to update
        }
    }
    
    //  SCORE CALCULATION LOGIC
    func updateScore(for bubble: Bubble) {
        
        //  CALCULATE SCORE for this bubble
        var bubbleScore = bubble.points
        if let lastColor = lastPoppedColor, lastColor == bubble.colorName {
            
            //  If the LAST POPPED BUBBLE is the SAME color, APPLY THE BONUS
            bubbleScore = Int(Double(bubble.points) * 1.5)
        }
        
        //  UPDATE the CURRENT SCORE
        currentScore += bubbleScore
        
        //  UPDATE the LAST POPPED COLOR
        lastPoppedColor = bubble.colorName
    }
    
    //  GENERATE & REFRESH BUBBLES
    //  BUBBLES CREATING at RANDOM spots & size.
    func generateBubbles() {
        //bubbles.removeAll { !$0.popped } // Remove non-popped bubbles before generating new ones
        
        //REMOVE A RANDOM AMOUNT
        bubbles = []
        
        let bubblesToCreate = Int.random(in: 1...maxBubbles)
        for _ in 0..<bubblesToCreate {
            //  SELECT RANDOM BUBBLE BASED ON PROBABILITY
            let newBubble = randomBubble_Probability()
            // CHECK FOR OVERLAPS
            let newPosition = generateNonOverlappingPosition(for: newBubble)
            var newBubbleWithPosition = newBubble
            //  RANDOM SPOT
            newBubbleWithPosition.position = newPosition!
            // ADD new Bubbles to the LIST of all Bubbles
            bubbles.append(newBubbleWithPosition)
        }
    }
    
    
    //  SELECT RANDOM BUBBLEs BASED ON its PROBABILITY
    func randomBubble_Probability() -> Bubble {
        
        //let totalProbability = bubbleTypes.map { $0.probability }.reduce(0, +)
        let totalProbability = bubbleTypes.reduce(0) { $0 + $1.probability }
        let randomPoint = Double.random(in: 0..<totalProbability)
        var accumulator: Double = 0
        
        for bubble in bubbleTypes {
            accumulator += bubble.probability
            if randomPoint < accumulator {
                
                var newBubble = bubble
                newBubble.id = UUID().uuidString  // Ensure each bubble has a unique ID when generated
                
                return newBubble
                //return bubble
            }
        }
        // Fallback to the last bubble type if all else fails
        return bubbleTypes.last!
    }
    
    // MARK: - HELPER FUNCTION FOR BUBBLES
    
    //  TO CHECK if 2 bubbles OVERLAP
    func generateNonOverlappingPosition(for bubble: Bubble) -> CGPoint? {
        var potentialPosition: CGPoint
        
        //  TO ENSURE the bubble is FULLY WITHIN the SCREEN BOUNDS
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let maxAttempts = 10000  // Set a reasonable limit to attempts for finding a position
        var attempts = 0
        
        repeat {
            let x = CGFloat.random(in: bubble.size/2...(screenWidth - bubble.size/2))
            let y = CGFloat.random(in: bubble.size/2...(screenHeight - 150 - bubble.size/2))
            potentialPosition = CGPoint(x: x, y: y)
            attempts += 1
            if attempts > maxAttempts {
                print("Unable to find a non-overlapping position after \(maxAttempts) attempts.")
                return nil  // Return nil if a position isn't found to handle the error gracefully.
            }
        } while bubbles.contains(where: { $0.position.isTooClose(to: potentialPosition, minimumDistance: bubble.size) })
        
        return potentialPosition
    }
}   //  CLASS S.

extension CGPoint {
    func isTooClose(to other: CGPoint, minimumDistance: CGFloat) -> Bool {
        let dx = self.x - other.x
        let dy = self.y - other.y
        return sqrt(dx*dx + dy*dy) < minimumDistance
    }
}
