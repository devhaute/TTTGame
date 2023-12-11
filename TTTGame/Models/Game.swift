//
//  Game.swift
//  TTTGame
//
//  Created by kai on 12/9/23.
//

import Foundation

struct Game: Codable, Identifiable {
    let id: String
    
    var player1ID: String
    var player1Score: String
    
    var player2ID: String
    var player2Score: String
    
    var activePlayerID: String
    var winnigPlayerID: String
    
    var moves: [GameMove?]
}
