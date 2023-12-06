//
//  GameMove.swift
//  TTTGame
//
//  Created by kai on 12/5/23.
//

import Foundation

struct GameMove: Codable {
    let player: Player
    let boardIndex: Int
    
    // SF Symbols
    var indicator: String {
        player == .player1 ? "xmark" : "circle"
    }
}
