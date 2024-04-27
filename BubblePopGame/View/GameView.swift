//
//  GameView.swift - THE INTERFACE
//                 - ACCESS & MODIFY THE OBJECT'S INSTANCE "bubbles"                                                       (GameViewModel CLASS)
//  BubblePopAss
//

import SwiftUI

// TEST GIT

struct GameView: View {
    
    /*  MARK: CUSTOM COLOUR */
    
    @StateObject var viewModel: GameViewModel
    
    //@StateObject var highScoreViewModel = HighScoreViewModel()
    @StateObject var highScoreViewModel: HighScoreViewModel
    @State var isGameFinished: Bool = false //  TRIGGER SCOREBOARD
    
    /* -- TEST --
     
     @State var b=Bubble(position: CGPoint(x: 80, y: 50), color: Color.red, colorName: "", points: 0, probability: 0.0)
     
      -- TEST -- */
    
    /*  MARK: INITIALIZER DECLARE
     HOW TO PASS VALUE INTO VIEWMODEL */
                                            
    init(gameTimeControl: Int, bubblesControl: Int) {
        
        let highScoreVM = HighScoreViewModel(playerName: "", score: 0)
        
        _viewModel = StateObject(wrappedValue: GameViewModel(gameTimeLeft: gameTimeControl, maxBubbles: bubblesControl, highScoreViewModel: highScoreVM))
        //_highScoreViewModel = StateObject(wrappedValue: HighScoreViewModel(playerName: "Default Player", score: 0))
        _highScoreViewModel = StateObject(wrappedValue: highScoreVM)
    }
    
    /*  MARK: MAIN VIEW */
    
    var body: some View { // BODY S.
        
        ZStack { // ZSTACK S.
            
            //  DISPLAY GAME'S BACKGROUND
            gameTheme
            
            //  DISPLAY BUBBLES
            bubbleDisplay
            
            //  DISPLAY SCOREBOARD
            finishGameButton
            
            //  DISPLAY HUDView [ Head-Ups ] included "Time", "Score", "HighScore"
            GeometryReader { // Geometry S.
                
                geometry in VStack { // VStack S.
                    
                    topPanel
                    Spacer()
                    
                } // VStack E.
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                //.border(.red)
                .onAppear() {
                    print("Screen Height: \(geometry.size.height), Screen Width: \(geometry.size.width)")
                }
            } // Geometry E.
            
        }   // ZSTACK E.
        
        //  RUN Everytime Views CREATE in a memory
        .onReceive(viewModel.timer, perform: { _ in
            viewModel.countDown()
            gameProcessing()
        })
        
    }// BODY E.
    
    // MARK: - SUBVIEWS

    /* ▛▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▜
       ▌☾☁𐋐▂▃▅▇█▓▒░ ❝ 🌵𝐂 𝐇 𝐈 𝐋 𝐃 • 𝐕 𝐈 𝐄 𝐖🌵 ❞ ░▒▓█▇▅▃▂𐋐☾☁ ▌
       ▙▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▟ */
    
    
    /*  MARK: BACKGROUND for GAME */
    
    var gameTheme: some View {
        Image("GameBGR")
            .resizable()
            .edgesIgnoringSafeArea(.all)
    }
    
    
    /*  MARK: DISPLAY HUDView [ Head-Ups ] included "Time", "Score", "HighScore" */
    
    var topPanel: some View {
        
        HStack { // HStack S.
            
            //  DISPLAY COUNTDOWN TIMER
            Text("Time Left \n\(viewModel.gameTimeLeft)")
            //.font(.title2)
                .font(.custom("Reglisse", size: 30))
                .fontWeight(.heavy)
                .foregroundStyle(.teal)
                .multilineTextAlignment(.center)
                .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
            
             
                .shadow(color: .white, radius: 3, x: 0, y: 1)
                .shadow(color: .white, radius: 3, x: 0, y: -1)
            
                .padding()
            
            //  DISPLAY CURRENT SCORE
            Text("Score \n \(viewModel.currentScore) ")
            //highScoreViewModel.score
                .font(.custom("Reglisse", size: 30))
                .fontWeight(.heavy)
                .foregroundStyle(.teal)
                .multilineTextAlignment(.center)
                .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
            
                .shadow(color: .white, radius: 3, x: 0, y: 1)
                .shadow(color: .white, radius: 3, x: 0, y: -1)
            
                .padding()
            
            //  DISPLAY PLAYER'S HIGH SCORE
            Text("High Score \n \(highScoreViewModel.highScore)") //highScoreViewModel.highscores[0]
                .font(.custom("Reglisse", size: 30))
                .fontWeight(.heavy)
                .foregroundStyle(.teal)
            
                .shadow(color: .white, radius: 3, x: 0, y: 1)
                .shadow(color: .white, radius: 3, x: 0, y: -1)
            
                .padding()
                .multilineTextAlignment(.center)
                .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
            
        } //    HStack E.
    }
    
    
    /*  MARK: DISPLAY BUBBLES */
    
    var bubbleDisplay: some View {
        
        ForEach(viewModel.bubbles) { bubble in
                    
            BubbleView(bubble: Binding(get: {
                bubble
            }, set: { newBubble in
                if let index = viewModel.bubbles.firstIndex(where: { $0.id == newBubble.id }) {
                    viewModel.bubbles[index] = newBubble

                }
            }), popBubbleAction: {
                viewModel.popBubble(bubble)
                highScoreViewModel.addScoreIfHigher(playerName: highScoreViewModel.playerName, score: viewModel.currentScore)
                highScoreViewModel.savePlayerScores()
            })
            
        }
        .onDelete { indexSet in
            //  viewModel.bubbles.remove(atOffsets: indexSet)
            DispatchQueue.main.async {
                viewModel.bubbles.remove(atOffsets: indexSet)
            }
        }
    }
    
    
    /*  MARK: DISPLAY SCOREBOARD - Finish Game Button */
    
    var finishGameButton: some View {
        
        Button("Finish Game") {
            //highScoreViewModel.score = Int.random(in: 0...100)
            
            // TRIGGER NAVIGATION by setting this state
            //isGameFinished = true
        }
        /*.sheet(isPresented: $isGameFinished, content: {
            HighScoreView(showPlayer: highScoreViewModel.playerName, highScore: highScoreViewModel.score, currentScore: $viewModel.currentScore)//.environmentObject(highScoreViewModel)
            
        }) */
        .navigationDestination(isPresented: $isGameFinished) {
            //HighScoreView(showPlayer: highScoreViewModel.playerName, highScore: highScoreViewModel.score)
            HighScoreView(gameViewModel: viewModel)
        }
        .hidden()
    }
    
    
    // MARK: - FUNCTIONS

    /* ▛▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▜
       ▌ ☾☁𐋐☀▂▃▅▇█▓▒░ ❝ 🌵𝐅 𝐔 𝐍 𝐂 𝐓 𝐈 𝐎 𝐍🌵 ❞ ░▒▓█▇▅▃▂𐋐☀☾☁  ▌
       ▙▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▟ */
    
    
    //  COTROL WHEN GAME START & GAME END (❣•‿•❣)
    //  POP UP THE HIGHSCORE_VIEW when the game finishes ✿♥‿♥✿
    func gameProcessing() {
        if viewModel.gameTimeLeft <= 0 {
            isGameFinished = true
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack { // 60
        GameView(gameTimeControl: 120, bubblesControl: 15)
    }
}
