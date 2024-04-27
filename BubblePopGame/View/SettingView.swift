//
//  SettingView.swift
//  BubblePopGame
//


import SwiftUI
/*  MARK: - SETTINGS VIEW */

struct SettingView: View { // STRUCT S.
    
    @StateObject var viewModel = SettingViewModel()
    @State var isDisplay: Bool = false
    let screenHeight = UIScreen.main.bounds.height
    
    /*  MARK: MAIN VIEW */
    
    var body: some View {   // BODY S.
        
        ZStack {
            
            Image("SettingBG")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {    // VStack S.
               
                settingSymbol;
                
                VStack {    // VStack2 S.
                    
                    //  PLAYER
                    //  PLAYER NAME LABEL
                    playerName_Label

                    //  INPUT PLAYER NAME
                    inputPlayerName
                    
                    //  GAME SETTING
                    //  TIMER SETTING
                    VStack {
                        
                        HStack() {

                            Text("Time Limit  :   \(Int(viewModel.gameTimeLimit))")
                                .font(.custom("Reglisse", size: 30))
                                .foregroundStyle(.white)
                                .shadow(color: .black, radius: 3, x: 0, y: 0)
                                .shadow(color: .black, radius: 3, x: 1, y: 0)
                                .shadow(color: .white, radius: 3, x: -1, y: 0)
                                .shadow(color: .black, radius: 3, x: 0, y: 1)
                                .shadow(color: .white, radius: 3, x: 0, y: -1)
                                .padding()
                                .multilineTextAlignment(.center)
                                .lineSpacing(11.0)
                            
                            Slider(value: $viewModel.gameTimeLimit, in: 1...120, step: 1.0)
                                .padding(.horizontal)
                                .tint(.orange)
                            //.accentColor(.orange) //baby blue
                        }

                        //  BUBBLES SETTING
                        HStack {
                            Text("Bubbles Quantity  :  \(Int(viewModel.numberOfBubbles))")
                                .font(.custom("Reglisse", size: 30))
                                .foregroundStyle(.white) //darkblue
                                .shadow(color: .black, radius: 3, x: 0, y: 0)
                                .shadow(color: .black, radius: 3, x: 1, y: 0)
                                .shadow(color: .white, radius: 3, x: -1, y: 0)
                                .shadow(color: .black, radius: 3, x: 0, y: 1)
                                .shadow(color: .white, radius: 3, x: 0, y: -1)
                                .padding()
                                .multilineTextAlignment(.center)
                                .lineSpacing(11.0)
                            
                            
                            Slider(value: $viewModel.numberOfBubbles, in: 1...15, step: 1.0)
                                .padding(.horizontal)
                                .tint(.orange)
                        }
                    }
                    .offset(y: screenHeight * -0.05)
                    
                }.offset(y: screenHeight * -0.03) // VStack2 E.
                
                //  NAVIGATE BETWEEN VIEWS ["SettingView" to "CountDownView"]
                startGameLink

            }   //  VStack E.
            .padding()
        }
        
    }   // BODY E.
    
    // MARK: - SUBVIEWS

    /* ▛▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▜
       ▌☾☁𐋐▂▃▅▇█▓▒░ ❝ 🌵𝐂 𝐇 𝐈 𝐋 𝐃 • 𝐕 𝐈 𝐄 𝐖🌵 ❞ ░▒▓█▇▅▃▂𐋐☾☁ ▌
       ▙▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▟ */
    
    
    /*  MARK: SETTING SYMBOL VIEW  */
    
    var settingSymbol: some View {
        
        
        HStack {
            Image(systemName: "gearshape.fill")
                .font(.system(size: 100))
                .bold()
                .foregroundStyle(hex_Gradient)
                .shadow(color: .black, radius: 3, x: 0, y: 0)
                .shadow(color: .white, radius: 3, x: 1, y: 0)
                .shadow(color: .black, radius: 3, x: -1, y: 0)
                .shadow(color: .white, radius: 3, x: 0, y: 1)
                .shadow(color: .white, radius: 3, x: 0, y: -1)
                .padding(25)
                .offset(y: screenHeight * -0.02)
            
            Button {
                isDisplay = true
                
            } label: {
                
                Image(systemName: "person.crop.circle.badge.questionmark.fill")
                    .font(.system(size: 50))
                    .bold()
                    .foregroundStyle(hex_Gradient)
                    .shadow(color: .black, radius: 3, x: 0, y: 0)
                    .shadow(color: .white, radius: 3, x: 1, y: 0)
                    .shadow(color: .black, radius: 3, x: -1, y: 0)
                    .shadow(color: .white, radius: 3, x: 0, y: 1)
                    .shadow(color: .white, radius: 3, x: 0, y: -1)
                    .padding(25)
                    .offset(y: screenHeight * -0.02)
            }
            .sheet(isPresented: $isDisplay, content: {
                
                InstructionsView()
            })
            
        }
        //.background(.yellow) - SEE how padding work
        
    }
    
    /*  🌵PLAYER🌵  */
    /*  MARK: DISPLAY PLAYER'S NAME LABEL  */
    
    var playerName_Label: some View {
        
        HStack {
            
            Image(systemName: "bubbles.and.sparkles.fill")
                .font(.system(size: 55))
                .foregroundStyle(Color.yellow)
                .shadow(color: .white, radius: 3, x: 0, y: 0)
                .shadow(color: .white, radius: 3, x: 1, y: 0)
                .shadow(color: .white, radius: 3, x: -1, y: 0)
                .shadow(color: .white, radius: 3, x: 0, y: 1)
                .shadow(color: .white, radius: 3, x: 0, y: -1)
            
            Text("Player Name")
                .font(.custom("Reglisse", size: 30))
                .foregroundStyle(.white)
                .shadow(color: .black, radius: 3, x: 0, y: 0)
                .shadow(color: .black, radius: 3, x: 1, y: 0)
                .shadow(color: .white, radius: 3, x: -1, y: 0)
                .shadow(color: .black, radius: 3, x: 0, y: 1)
                .shadow(color: .white, radius: 3, x: 0, y: -1)
                .padding()
            
            Image(systemName: "bubbles.and.sparkles.fill")
                .font(.system(size: 55))
                .foregroundStyle(Color.yellow)
                .shadow(color: .white, radius: 3, x: 0, y: 0)
                .shadow(color: .white, radius: 3, x: 1, y: 0)
                .shadow(color: .white, radius: 3, x: -1, y: 0)
                .shadow(color: .white, radius: 3, x: 0, y: 1)
                .shadow(color: .white, radius: 3, x: 0, y: -1)
            
        } // HSTACK E.
    }
    
    /*  MARK: INPUT PLAYER NAME  */
    
    var inputPlayerName: some View {
        
        //  Text("\(viewModel.playerName)")
        TextField("USERNAME", text: $viewModel.playerName)
            .multilineTextAlignment(.center)
            .font(.system(size: 25))
            .bold()
            .foregroundStyle(babyBlue)
            .frame(height: 50)
        //.textFieldStyle(RoundedBorderTextFieldStyle())
            .autocapitalization(.allCharacters)
            .padding([.leading,.trailing], 60)
        //.padding(EdgeInsets(top: 0, leading: 100, bottom: 0, trailing: 100))
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(babyBlue, lineWidth: 3.0)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.black)
                    )
            )
            .padding([.leading,.trailing], 50)
            .padding(.bottom, 90)
    }
    
    /*  🌵GAME SETTING🌵  */
    /*  MARK: BUTTON NAVIGATION TO START GAME VIEW  */
    
    var startGameLink: some View {
        //  NAVIGATE BETWEEN VIEWS ["SettingView" to "CountDownView"]
        NavigationLink {
            //  ACTION • PASSING DATA TO VIEW
            //  LINK Between SettingView & GameView
            
            //GameView(gameTimeControl: Int(viewModel.gameTimeLimit), bubblesControl: Int(viewModel.numberOfBubbles))
            
            CountDownView(gameViewModel: GameViewModel(gameTimeLeft: Int(viewModel.gameTimeLimit), maxBubbles: Int(viewModel.numberOfBubbles), highScoreViewModel: HighScoreViewModel(playerName: viewModel.playerName, score: 0)))
            
        } label: {
            Text("Start Game")
                .font(.custom("CutneyPersonalUse", size: 38))
            //.font(.headline)
                //.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding()
                .frame(height: 68)
                .background(pink)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 18.0))
                .overlay(
                    RoundedRectangle(cornerRadius: 18.0)
                        .stroke(.white, lineWidth: 2.5) // Specify the color and width of the border here
                )
                .shadow(radius: 100)
                .padding()
        }.offset(y: screenHeight * -0.07 )
    }
}    // STRUCT E.

// MARK: - Preview

#Preview {
    NavigationStack { //  Need to HAVE NavigtionStack to used Navigation Link
        SettingView()
    }
}
