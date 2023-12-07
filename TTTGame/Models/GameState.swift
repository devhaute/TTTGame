//
//  GameState.swift
//  TTTGame
//
//  Created by kai on 12/7/23.
//

import Foundation

enum GameState {
    case finished, draw, waitingForPlayer, quit
    
    var description: String {
        switch self {
        case .finished:
            return AppString.gameHasFinished
        case .draw:
            return AppString.draw
        case .waitingForPlayer:
            return AppString.waitingForPlayer
        case .quit:
            return AppString.playerLeft
        }
    }
}
