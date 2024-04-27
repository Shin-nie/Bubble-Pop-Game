//
//  SettingViewModel.swift - DECLARE OBJECT'S PROPERTIES [ PLAIN CLASS ]
//                         - DECLARE MENU SETTINGS
//  BubblePopGame
//

import Foundation
import SwiftUI

class SettingViewModel: ObservableObject {
    
    @Published var gameTimeLimit: Double = 60.0 //  SHARING VAR AMONG MULTIPLE VIEWS
    
    //  Number of bubbles
    @Published var numberOfBubbles: Double = 15.0
    
    @AppStorage("userName") var playerName: String = "" // LINKED WITH HIGHSCORE "userName" key
    //  have a key userName
    //  SAVING USER INPUT INTO the DATA BASE - QUIT APP data still there
    //  SET UP to be persistance
}
