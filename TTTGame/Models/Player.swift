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
            return AppString.player1
        case .player2:
            return AppString.player2
        case .cpu:
            return AppString.computer
        }
    }
}
