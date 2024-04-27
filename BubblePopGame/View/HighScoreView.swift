//
//  HighScoreView.swift
//  BubblePopGame
//
//  Created by Hang Vu on 8/4/2024.
//

import SwiftUI

struct HighScoreView: View {
    
    //@StateObject var viewModel = HighScoreViewModel() - WAY 1
    @ObservedObject var viewModel: HighScoreViewModel // (2)
    //@Binding var currentScore: Int
    @ObservedObject var gameViewModel: GameViewModel
    
    //  HOW TO PASS VALUE INTO VIEWMODEL
    //  INITIALISER DECLARE
    
    /*  TEST BINIDNG WAY
    //    init(showPlayer: String, highScore: Int, Binding<Int> score) {
    //        _viewModel = StateObject(wrappedValue: HighScoreViewModel(playerName: showPlayer, score: highScore))
    //        //self._currentScore = currentScore  // Use _variableName to assign to a Binding
    //    }
        TEST BINIDNG WAY  */
    
    /*  MARK: HOW TO PASS VALUE INTO VIEWMODEL
                INITIALISER DECLARE            */
    
    init(gameViewModel: GameViewModel) {
        self._gameViewModel = ObservedObject(wrappedValue: gameViewModel)
        self._viewModel = ObservedObject(wrappedValue: gameViewModel.highScoreViewModel)
    }
    
    /*  MARK: MAIN VIEW */
    
    var body: some View {   //  BODY S.
        
        ZStack {
            
            bgTheme
            
            VStack { // VSTACK S.
                
                //  DISPLAY HIGHSCORE LABEL
                highScoreLabel
                
                //  SHOW PLAYER SCORE LIST
                displayHighScore
                
                //  SHOW CURRENT SCORE
                displayCurrentScore
                
                //  BUTTON
                //  DELEATE ALL SCORE
                deleteAllScore
                
                //  BACK TO HOME MENU
                homeMenu
                
            }//  VSTACK E.
        }
        
    } //  BODY E.
    
    // MARK: - SUBVIEWS
    
    /* ▛▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▜
       ▌☾☁𐋐▂▃▅▇█▓▒░ ❝ 🌵𝐂 𝐇 𝐈 𝐋 𝐃 • 𝐕 𝐈 𝐄 𝐖🌵 ❞ ░▒▓█▇▅▃▂𐋐☾☁ ▌
       ▙▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▟ */
    
    
    /*  MARK: BG THEME  */
    var bgTheme: some View {
        Image("ScoreboardBG")
            .resizable()
            .edgesIgnoringSafeArea(.all)
    }
    
    /*  MARK: HIGHSCORE LABEL  */
    
    var highScoreLabel: some View {
        
        HStack {
            
            Image(systemName: "bubbles.and.sparkles.fill")
                .font(.system(size: 40))
                .foregroundStyle(Color.yellow)
                .shadow(color: .white, radius: 3, x: 0, y: 0)
                .shadow(color: .white, radius: 3, x: 1, y: 0)
                .shadow(color: .white, radius: 3, x: -1, y: 0)
                .shadow(color: .white, radius: 3, x: 0, y: 1)
                .shadow(color: .white, radius: 3, x: 0, y: -1)
            
            Label("High Score", systemImage: "")
                .font(.custom("Reglisse", size: 50))
                .foregroundStyle(pink)
                .bold()
                .shadow(color: .white, radius: 3, x: 0, y: 0)
                .shadow(color: .white, radius: 3, x: 1, y: 0)
                .shadow(color: .white, radius: 3, x: -1, y: 0)
                .shadow(color: .white, radius: 3, x: 0, y: 1)
                .shadow(color: .white, radius: 3, x: 0, y: -1)
                //.padding(.top, 15)
                //.padding(.bottom, -20)
            
            Image(systemName: "bubbles.and.sparkles.fill")
                .font(.system(size: 40))
                .foregroundStyle(Color.yellow)
                .shadow(color: .white, radius: 3, x: 0, y: 0)
                .shadow(color: .white, radius: 3, x: 1, y: 0)
                .shadow(color: .white, radius: 3, x: -1, y: 0)
                .shadow(color: .white, radius: 3, x: 0, y: 1)
                .shadow(color: .white, radius: 3, x: 0, y: -1)
        }
        .padding(.bottom, -10)
        
    }
    
    /*  MARK: SETTING SYMBOL VIEW  */
    
    var displayHighScore: some View {
        
        //  SHOW PLAYER SCORE LIST
        ForEach(viewModel.playerScores) { //.sorted(by: { $0.score > $1.score}).prefix(5)
            playerListScore in HStack {
                
                Text("\(playerListScore.userName)")
                    .frame(maxWidth: .infinity)
                    .font(.custom("Reglisse", size: 25))
                
                Text("\(playerListScore.score)")
                    .frame(maxWidth: .infinity)
                    .font(.custom("Reglisse", size: 25))
            } //HSTACK E.
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .foregroundStyle(navy)
            .background(Material.regular)
            .background(Color("BGColor"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
        }// For Each E.
        .onAppear {
            //viewModel.loadPlayerScores()
            //viewModel.savePlayerScores()
        }
        .padding()
        .padding(.bottom, -50)
        //.background(.green)
    }
    
    /*  MARK: DISPLAY CURRENT SCORE OF PLAYER  */
    
    var displayCurrentScore: some View {
        
        VStack { // VSTACK S3.
            
            VStack {// VSTACK S2.
                Label("Your Score", systemImage: "")
                    .font(.custom("Reglisse", size: 50))
                    .foregroundStyle(pink)
                    .bold()
                    .shadow(color: .white, radius: 3, x: 0, y: 0)
                    .shadow(color: .white, radius: 3, x: 1, y: 0)
                    .shadow(color: .white, radius: 3, x: -1, y: 0)
                    .shadow(color: .white, radius: 3, x: 0, y: 1)
                    .shadow(color: .white, radius: 3, x: 0, y: -1)
                //.background(.yellow)
                
                HStack {// HSTACK S2.
                    
                    Text (" \(viewModel.playerName == "" ? "None" : "\(viewModel.playerName)")")
                        .font(.custom("Reglisse", size: 25))
                        .frame(maxWidth: .infinity)
                        .fontWeight(.medium)
                    
                    Text("\(gameViewModel.currentScore == 0 ? "None" : "\(gameViewModel.currentScore)")")
                        .frame(maxWidth: .infinity)
                        .font(.custom("Reglisse", size: 25))
                    
                }// HSTACK E2.
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .foregroundStyle(steelBlue)
                //.background(Material.regular)
                .background(Color("BGColor"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                //.padding()
                .padding()
                .padding(.bottom, 50)
                //.background(.pink)
            }// VSTACK S2.
            .padding(.top, 50)
            //.background(.yellow)
            .padding(.bottom, -20)
        }// VSTACK E3.
        
    }
    
    /*  MARK: DISPLAY DELETE ALL SCORE BUTTON  */
    
    var deleteAllScore: some View {
        
        Button {
            //  ACTION
            viewModel.deleteAll()
            //currentScore = 0
            viewModel.playerName = ""
            
        } label: {
            Text("DELETE ALL")
                .font(.custom("CutneyPersonalUse", size: 38))
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(.red)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                .overlay(
                    RoundedRectangle(cornerRadius: 18.0)
                        .stroke(.white, lineWidth: 2.5) // Specify the color and width of the border here
                )
                .padding()
                .padding(.top, -50)
        }
    }
    
    /*  MARK: DISPLAY BACK TO HOME MENU BUTTON  */
    
    var homeMenu: some View {
        
        //  BACK TO MENU VIEW
        NavigationLink {
            //  ACTION
            MenuView()
            
        } label: {
            Text("HOME")
                .font(.custom("CutneyPersonalUse", size: 38))
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(
                    RoundedRectangle(cornerRadius: 20.0)
                    //.stroke(lineWidth: 1)
                        .foregroundStyle(babyBlue) //hex_Gradient
                )
            
                .foregroundColor(.white)
            //.clipShape(RoundedRectangle(cornerRadius: 20.0))
                .overlay(
                    RoundedRectangle(cornerRadius: 18.0)
                        .stroke(.white, lineWidth: 2.5) // Specify the color and width of the border here
                )
                .padding()
                .padding(.top, -20)
            
        }
        
    }
    
}

// MARK: - Preview

struct HighScoreView_Previews: PreviewProvider {
    @State static var previewCurrentScore: Int = 0  // Temporary @State variable
    
    static var previews: some View {
        NavigationStack {
            
            //  CREATE an instance of GameViewModel with a dummy HighScoreViewModel
            let previewHighScoreViewModel = HighScoreViewModel(playerName: "Preview Player", score: 100)
            let previewGameViewModel = GameViewModel(gameTimeLeft: 300, maxBubbles: 50, highScoreViewModel: previewHighScoreViewModel)
            
            //  PASS the GameViewModel instance to the HighScoreView
            HighScoreView(gameViewModel: previewGameViewModel)
        }
    }
}
