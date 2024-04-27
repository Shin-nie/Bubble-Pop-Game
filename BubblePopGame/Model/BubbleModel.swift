//
//  BubbleModel.swift - - DECLARE OBJECT'S PROPERTIES [ PLAIN CLASS ]
//                      - DECLARE BUBBLES'S PROPERTIES (Color, Points, & Probabilitiy)
//  BubblePopAss
//

import Foundation
import SwiftUI

struct Bubble: Identifiable {  //  CREATE UNIQUE ID FOR EACH BUBBLES
    
    var id: String = UUID().uuidString
    
    //  DEFINE POSITION AND SIZE OF A BUBBLES
    var position: CGPoint        //  Allow "x(Horizontal Position)" & "y(Vertical Position)" • two-dimentional                                                                                          coordinate system
    let size: CGFloat = 100     //  Size
    
    //  COLOR of the Bubbles
    let color: Color            //  SwiftUI's Color
    let colorName: String       //  FOR Comparision and Logic
    
    //  POINT of the Bubbles
    let points: Int
    
    //  PROBABILITY OF APPEARANCE
    let probability: Double
    
    var popped: Bool = false    // TRACK whether the bubble has been popped
    
}



