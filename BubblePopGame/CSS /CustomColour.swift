//
//  CustomColour.swift
//  BubblePopGame

import Foundation
import SwiftUI

/*  MARK: CUSTOM COLOUR */

func CustomColor(_ red: Double, _ green: Double, _ blue: Double) -> Color{
    return Color(red: red/255, green: green/255, blue: blue/255);
}

let lightCyan = Color(red: 173/255, green: 216/255, blue: 230/255)
let lightGreen = Color(red: 180/255, green: 255/255, blue: 189/255)
let lightPink = Color(red: 255/255, green: 241/255, blue: 243/255)
let pink = CustomColor(255, 131, 150);


let babyBlue = CustomColor(131, 213, 255);
let darkblue = CustomColor(0,55,84);
let navy = CustomColor(81, 153, 233)
let steelBlue = CustomColor(46, 85, 130)


// Function to create a LinearGradient using custom colors
func customGradient(_ colors: [Color], startPoint: UnitPoint, endPoint: UnitPoint) -> LinearGradient {
    return LinearGradient(gradient: Gradient(colors: colors), startPoint: startPoint, endPoint: endPoint)
}


// Define colors using RGB values
let startColor = Color(red: 1, green: 0.5, blue: 0) // Orange-Red
let middleColor = Color(red: 1, green: 0.8, blue: 0) // Orange
let endColor = Color(red: 0.5, green: 0, blue: 0.5) // Purple

// Define the RGB gradient
let hex_Gradient = customGradient([startColor, middleColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)

let black_Gradient = customGradient([.white, .gray, .black, .gray], startPoint: .top, endPoint: .bottom)

let blue_Gradient = customGradient([babyBlue, .cyan, babyBlue, darkblue], startPoint: .top, endPoint: .bottom)

let purple_yellow_Gradient = customGradient([endColor, startColor, middleColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)



