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
    
    @Published private(set) var moves: [GameMove?] = [
        nil, nil, nil,
        nil, nil, nil,
        nil, nil, nil
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
    
    func processMove(for position: Int) {
        if isSquareOccupied(in: moves, for: position) { return }
        
        moves[position] = .init(player: activePlayer, boardIndex: position)
        activePlayer = players.first(where: { $0 != activePlayer })!
    }
    
    // 점유하고 있는지 체크
    private func isSquareOccupied(in moves: [GameMove?], for index: Int) -> Bool {
        moves.contains(where: { $0?.boardIndex == index })
    }
}
