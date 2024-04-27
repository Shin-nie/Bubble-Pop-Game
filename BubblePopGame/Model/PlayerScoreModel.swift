//
//  PlayerScoreModel.swift
//  BubblePopGame
//

import Foundation
struct PlayerScore: Identifiable, Codable {  // CREATE UNIQUE ID FOR EACH Player
    //  Codeable : LET ENCODING & DECODING EASIER
    var id: String = UUID().uuidString
    let userName: String
    var score: Int
    
}
