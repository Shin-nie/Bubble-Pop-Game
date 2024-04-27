//
//  CountDownView.swift
//  BubblePopGame
//

import SwiftUI

struct CountDownView: View {
    
    @StateObject var gameViewModel: GameViewModel
    //@StateObject var settingView: SettingViewModel
    @State private var countDown: Int = 3
    @State private var startGame: Bool = false //isCountingDown
    @State private var displayStart: Bool = false
    
    /*  MARK: MAIN VIEW */
    var body: some View {
        ZStack {
            
            bgTheme
            
            VStack {
                
                if displayStart { //== true
                    startText()
                }
                else {
                    countDownText()
                }
                
            } // VSTACK E.
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect(), perform: updateCountdown(_:))
            .navigationDestination(isPresented: $startGame, destination: gameView)
            .navigationBarBackButtonHidden(true)
        }
        
    }
    
    //  SUB-VIEW
    var bgTheme: some View {
        
        Image("CountDownBG")
            .resizable()
            .edgesIgnoringSafeArea(.all)
    }
    
    //  FUNCTION
    //
    //  START COUNTING DOWN
    func updateCountdown(_ Time: Timer.TimerPublisher.Output) {
        if countDown > 1 {
            countDown -= 1
        }
        else if !displayStart {
            displayStart = true
            prepareForGameStart()
        }
    }
    
    //  PREPARE FOR GAME START
    func prepareForGameStart() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            startGame = true
        }
    }
    
    //  DISPLAY COUNT DOWN TIMER
    func countDownText() -> some View {
        
        Text("\(countDown)")
            .font(.custom("InflatePTx-Chrome", size: 180))
        //.fontWeight(.bold)
            .opacity(0.7)
    }
    
    //  DISPLAY "START" TEXT
    //  CHILD VIEW
    func startText() -> some View {
        
        Text("G O !")
            .font(.custom("InflatePTx-Chrome", size: 145))
        //.fontWeight(.bold)
            .opacity(0.7)
            .foregroundStyle(pink)
            .padding()
        
            .onAppear(perform: prepareForGameStart)
    }
    
    @ViewBuilder
    //  NAVIGATE TO GAME VIEW
    func gameView() -> some View {
        GameView(gameTimeControl: gameViewModel.gameTimeLeft, bubblesControl: gameViewModel.maxBubbles)
    }
    
}

// MARK: - Preview

struct StartGameView_Previews: PreviewProvider {
    static var previews: some View {
        CountDownView(gameViewModel: GameViewModel(gameTimeLeft: 60, maxBubbles: 15, highScoreViewModel: HighScoreViewModel(playerName: "Player", score: 0)))
    }
}
