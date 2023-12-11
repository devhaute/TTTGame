//
//  Player.swift
//  TTTGame
//
//  Created by kai on 12/5/23.
//

import Foundation

enum Player: Codable {
    case player1, player2, cpu
    
    var name: String {
        switch self {
        case .player1:
            return Constants.String.player1
        case .player2:
            return Constants.String.player2
        case .cpu:
            return Constants.String.computer
        }
    }
}
