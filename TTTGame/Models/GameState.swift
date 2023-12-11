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
            return Constants.String.gameHasFinished
        case .draw:
            return Constants.String.draw
        case .waitingForPlayer:
            return Constants.String.waitingForPlayer
        case .quit:
            return Constants.String.playerLeft
        }
    }
}
