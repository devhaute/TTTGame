//
//  GameViewModel.swift
//  TTTGame
//
//  Created by kai on 12/4/23.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Published private(set) var gameMode: GameMode
    @Published private(set) var player1Name: String = ""
    @Published private(set) var player1Score: UInt8 = 0
    @Published private(set) var player2Name: String = ""
    @Published private(set) var player2Score: UInt8 = 0
    @Published private(set) var activePlayer: Player = .player1
    @Published private var players: [Player]
    
    init(with gameMode: GameMode) {
        self.gameMode = gameMode
        
        switch gameMode {
        case .vsHuman:
            self.players = [.player1, .player2]
        case .vsCPU:
            self.players = [.player1, .cpu]
        case .online:
            self.players = [.player1, .player2]
        }
    }
}
