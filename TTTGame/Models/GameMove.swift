//
//  GameMove.swift
//  TTTGame
//
//  Created by kai on 12/5/23.
//

import Foundation

enum BoardCircleIndicator: String {
    case xmark, circle
}

struct GameMove: Codable {
    let player: Player
    let boardIndex: Int
    
    var indicator: BoardCircleIndicator {
        player == .player1 ? .xmark : .circle
    }
}
