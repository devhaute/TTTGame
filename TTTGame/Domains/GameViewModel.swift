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
    
    private let winPatterns: Set<Set<Int>> = [
         [0, 1, 2], [3, 4, 5], [6, 7, 8],
         [0, 3, 6], [1, 4, 7], [2, 5, 8],
         [0, 4, 8], [2, 4, 6]
    ]
    
    @Published private(set) var moves: [GameMove?] = [
        nil, nil, nil,
        nil, nil, nil,
        nil, nil, nil
    ]
    @Published private(set) var gameMode: GameMode
    @Published private(set) var player1Name: String = Player.player1.name
    @Published private(set) var player1Score: UInt8 = 0
    @Published private(set) var player2Name: String = Player.player2.name
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
        if isSquareOccupied(in: moves, for: position) { return } // 점유하고 있는지 체크
        moves[position] = .init(player: activePlayer, boardIndex: position)
        
        if checkForWin(in: moves) {
            resetGame()
            return
        }
        
        if checkForDraw(in: moves) {
            resetGame()
            return
        }
        
        activePlayer = players.first(where: { $0 != activePlayer })!
    }
    
    private func isSquareOccupied(in moves: [GameMove?], for index: Int) -> Bool {
        moves.contains(where: { $0?.boardIndex == index })
    }
    
    private func checkForWin(in moves: [GameMove?]) -> Bool {
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == activePlayer }
        let playerPositions = playerMoves.map({ $0.boardIndex })

        for pattern in winPatterns where pattern.allSatisfy({ playerPositions.contains($0) }) {
            if activePlayer == .player1 {
                player1Score += 1
            } else {
                player2Score += 1
            }
            
            return true
        }
        
        return false
    }
    
    private func checkForDraw(in moves: [GameMove?]) -> Bool {
        moves.count == moves.compactMap({ $0 }).count
    }
    
    private func resetGame() {
        activePlayer = .player1
        moves = Array(repeating: nil, count: moves.count)
    }
}
