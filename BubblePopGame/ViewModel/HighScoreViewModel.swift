//
//  HighScoreViewModel.swift
//  BubblePopGame
//

import Foundation
import SwiftUI

class HighScoreViewModel: ObservableObject {
    
    let userDefaults = UserDefaults.standard
    
    //  @AppStorage is for UserDefaults - LINK between "SETTINGVIEW_MODEL" & "HIGHSCOREVIEW_MODEL" as same KEY("userName")
    @AppStorage("userName") var playerName: String = ""
    @Published var playerScores: [PlayerScore] = []
    
    @Published var score: Int // = 500
    
    //  HOLD THE HIGHEST SCORE
    //  UPDATE THIS EVERYTIME UPDATED "playerScores"
    @Published var highScore: Int = 0
    //@Published var currentScore: Int = 0
    
    init(playerName: String, score: Int) {
        self.playerName = playerName
        //self.highscores = userDefaults.stringArray(forKey: "highScore") ?? []
        self.score = score
        loadPlayerScores() // Load scores upon initialization
    }
    
    // SAVED CURRENT SCORE
    func saveCurrentGameScore(playerName: String, score: Int) {
        //let newScore = PlayerScore(userName: playerName, score: score)
        //playerScores.append(newScore)
        
        // Saving the scores array to UserDefaults
        let userDefaults = UserDefaults.standard
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(playerScores) {
            userDefaults.setValue(encoded, forKey: "PlayerScores")
            
            // Optionally, update the high score if necessary
            //updateHighScore()
        }
    }
    
    //  RECOREDED EACH PLAYER'S HIGHEST SCORE
    //
    //  CHECK for DUPLICATED or whether the SCORE for that player has already been ADDED
    func addScoreIfHigher(playerName: String, score: Int) {
        if let index = playerScores.firstIndex(where: { $0.userName == playerName }) {
            // Player exists, update their score if the new score is higher
            if score > playerScores[index].score {
                playerScores[index].score = score
            }
        } else {
            // Player does not exist, add them
            let newScore = PlayerScore(userName: playerName, score: score)
            playerScores.append(newScore)
        }
        //savePlayerScores()
    }
    
    
    // CALL this method to UPDATE the high score whenever playerScores changes
    private func updateHighScore() {
        self.highScore = playerScores.sorted { $0.score > $1.score }.first?.score ?? 0
    }
    
    //  HELPER FUNCTION
    
    //  loadPlayerscores
    func loadPlayerScores() {
        
        let userDefaults = UserDefaults.standard
        
        if let data = userDefaults.data(forKey: "PlayerScores") {
            
            let decoder = JSONDecoder()
            
            if let decodedPlayerStores = try? decoder.decode([PlayerScore].self, from: data) {
                
                playerScores = decodedPlayerStores
            }
        }
        updateHighScore()
    }
    
    //  savePlayerScores
    func savePlayerScores() {
        
        //  SORT THE SCORE
        playerScores = playerScores.sorted(by: {$0.score > $1.score}).prefix(5).map{$0}
        
        //  SAVE THE UPDATED SCORES
        let userDefaults = UserDefaults.standard
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(playerScores) {
            userDefaults.setValue(encoded, forKey: "PlayerScores")
        }
        //  AFTER SAVING, UPDATE THE HIGH SCORE
        updateHighScore()
    }
    
    //  DELETE ALL PLAYER SCORE
    func deleteAll() {
        playerScores.removeAll()
        //highscores.removeAll()
        score = 0 //    RESET the highest score
        
        //playerScores.append(PlayerScore(userName: "", score: 0))
        
        userDefaults.setValue([], forKey: "PlayerScores")
    }
    
}
