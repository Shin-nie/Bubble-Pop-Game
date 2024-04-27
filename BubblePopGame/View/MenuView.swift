//
//  MenuView.swift
//  BubblePopGame
//

import SwiftUI

struct MenuView: View {
    
    @State private var orientation = UIDeviceOrientation.unknown
    
    /*  MARK: MAIN VIEW  */
    
    var body: some View { // BODY S.
        
        //  NAVIGATE BETWEEN VIEWS
        ZStack {
            
            //  GAME THEME
            gameBG
            
            VStack { // VSTACK S.
                
                if orientation.isLandscape {
                    
                    landscape_AppTitle
                    
                    //HStack {
                    landscape_SettingView
                    landscape_HighScoreView
                    //}
                    
                } else { //is Lanscape
                    
                    portrait_AppTitle
                    //responsiveApp
                    portrait_SettingView
                    portrait_HighScoreView
              
                }
                
            } //  VSTACK E.
        } //  ZSTACK E.
        .onRotate { newOrientation in
            orientation = newOrientation
        }
        
    } // BODY E.
    
 
    //  MARK: FONT FINDING
    /* TEST
     init() {
     for familyName in UIFont.familyNames {
     print(familyName)
     for fontName in UIFont.fontNames(forFamilyName: familyName) {
     print("-- \(fontName)")
     }
     }
     }
     TEST */
    
    
    /* ▛▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▜
     ▌☾☁𐋐▂▃▅▇█▓▒░ ❝ 🌵𝐂 𝐇 𝐈 𝐋 𝐃 • 𝐕 𝐈 𝐄 𝐖🌵 ❞ ░▒▓█▇▅▃▂𐋐☾☁ ▌
     ▙▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▟ */
    
    /*  MARK: GAME THEME  */
    
    var gameBG: some View {
        
        Image("Bubbles")
            .resizable()
        //.scaledToFit()
            .edgesIgnoringSafeArea(.all)
        
    }
    
    /*  MARK: APP TITTLE  */ //🌵
    
    var portrait_AppTitle: some View {
        VStack {
            Text("Bubble \nPop")
                .font(.custom("InflatePTx-Chrome", size: 80))//LaoutBeautyPersonalUse //CutneyPersonalUse
                .bold()
                .foregroundStyle(pink)
                .padding(.bottom, 5)
                .multilineTextAlignment(.center)
                .lineSpacing(30)// Increase the line spacing to add space between "Bubble" and "Pop"
                .frame(minWidth:0, maxWidth: .infinity)
        }
        //.padding(.top, -5)
        .padding(.bottom, 30)
        //.background(.yellow) //- SEE how padding work
        
    }
    
    var landscape_AppTitle: some View {
        VStack {
            Text("Bubble Pop")
                .font(.custom("InflatePTx-Chrome", size: 60)) // Smaller font size for landscape
                .bold()
                .foregroundStyle(pink)
                .padding(.bottom, 5)
                .multilineTextAlignment(.center) // Line spacing may not be needed as "Bubble Pop" is on a single line
        }
        .padding(.top, 25)
        .padding(.bottom, 10) // Less padding for compact landscape layout
    }
    
    /*  MARK: SETTING VIEW  */
    
    var portrait_SettingView: some View {
        
        //  NAVIGATE BETWEEN VIEWS
        NavigationLink {
            //  ACTION • PASSING DATA TO VIEW
            //  LINK Between "MenuView" & "SettingView", "GameView"
            SettingView()
        } label: {
            
            VStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20 ){
                
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 95))
                    .shadow(radius: 10)
                    .foregroundStyle(black_Gradient)
                    //.frame(width: 100, height: 100) // Adjust the frame to fit layout
                    .frame(minWidth:0, maxWidth: .infinity)
                
                HStack {
                    Text("NEW PLAY")
                        .font(.custom("InflatePTx-Chrome", size: 50))
                    
                } // HStack E.
                
            } // VStack E.
            
        } // label E.
        .padding(.bottom, 15)
    }
    
    var landscape_SettingView: some View {
        NavigationLink {
            SettingView()
        } label: {
            VStack {
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 80))
                    .shadow(radius: 10)
                    .foregroundStyle(black_Gradient)
                    .frame(width: 50, height: 100) // Adjust the frame to fit layout
                
                Text("NEW PLAY")
                    .font(.custom("InflatePTx-Chrome", size: 40))
            }
        }
        .padding(.bottom, 10)
    }
    
    /*  MARK: HIGH SCORE VIEW  */
    
    
    var portrait_HighScoreView: some View {
        
        //  NAVIGATE BETWEEN VIEWS
        NavigationLink {
            
            //  ACTION: Properly pass a GameViewModel instance
            let dummyHighScoreViewModel = HighScoreViewModel(playerName: "", score: 0)
            let dummyGameViewModel = GameViewModel(gameTimeLeft: 0, maxBubbles: 0, highScoreViewModel: dummyHighScoreViewModel)
            HighScoreView(gameViewModel: dummyGameViewModel)
            
        } label: {
            
            VStack(alignment: .center, spacing: 20) { // Vertically align the text components
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 95))
                    .shadow(radius: 10)
                    .foregroundStyle(blue_Gradient)
                    .frame(minWidth:0, maxWidth: .infinity) // Adjust the frame to fit layout
                
                // High
                HStack(spacing: 0) {
                    Text("HIGH SCORE")
                        .font(.custom("InflatePTx-Chrome", size: 50))
                }
            }
        }
    }
    
    var landscape_HighScoreView: some View {
        NavigationLink {
            prepareHighScoreView()
        } label: {
            VStack {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 70))
                    .shadow(radius: 10)
                    .foregroundStyle(blue_Gradient)
                    .frame(width: 80, height: 80)
                
                Text("HIGH SCORE")
                    .font(.custom("InflatePTx-Chrome", size: 40))
            }
        }
    }
    
    
    // Function to prepare GameViewModel before navigating to HighScoreView
    private func prepareHighScoreView() -> HighScoreView {
        let highScoreViewModel = HighScoreViewModel(playerName: "", score: 0) // No score to save
        let gameViewModel = GameViewModel(gameTimeLeft: 0, maxBubbles: 0, highScoreViewModel: highScoreViewModel)
        return HighScoreView(gameViewModel: gameViewModel)
    }
    
}

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        MenuView()
    }
}

