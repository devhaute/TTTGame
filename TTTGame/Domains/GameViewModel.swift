//
//  GameViewModel.swift
//  TTTGame
//
//  Created by kai on 12/4/23.
//

import SwiftUI
import Combine

final class GameViewModel: ObservableObject {
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Published private(set) var gameMode: GameMode
    @Published private(set) var gameNotification: String = ""
    @Published private var players: [Player]
    @Published private(set) var player1Name: String = ""
    @Published private(set) var player1Score: UInt8 = 0
    @Published private(set) var player2Name: String = ""
    @Published private(set) var player2Score: UInt8 = 0
    @Published private(set) var activePlayer: Player = .player1
    @Published private(set) var alertItem: AlertItem?
    @Published var showAlert: Bool = false
    @Published private(set) var moves: [GameMove?] = [
        nil, nil, nil,
        nil, nil, nil,
        nil, nil, nil
    ]
    
    private let winPatterns: Set<Set<Int>> = [
         [0, 1, 2], [3, 4, 5], [6, 7, 8],
         [0, 3, 6], [1, 4, 7], [2, 5, 8],
         [0, 4, 8], [2, 4, 6]
    ]
    
    private let centerPosition = 4
    
    init(with gameMode: GameMode) {
        self.gameMode = gameMode
        
        switch gameMode {
        case .vsHuman:
            players = [.player1, .player2]
        case .vsCPU:
            players = [.player1, .cpu]
        case .online:
            players = [.player1, .player2]
        }
        
        gameNotification = "It`s \(Player.player1.name)'s move"
        configure()
    }
    
    private func configure() {
        $players
            .compactMap(\.first?.name)
            .assign(to: &$player1Name)
        
        $players
            .compactMap(\.last?.name)
            .assign(to: &$player2Name)
    }
    
    private func switchActivePlayer() {
        activePlayer = players.first(where: { $0 != activePlayer })!
    }
    
    private func computerMove() {
        let timeRange: ClosedRange<UInt64> = 800_000_000...1_500_000_000
        let computerProcessingTime = UInt64.random(in: timeRange)
        
        Task { @MainActor in
            try await Task.sleep(nanoseconds: computerProcessingTime)
            processMove(for: getAIMovePosition(in: moves))
        }
    }
    
    private func getAIMovePosition(in moves: [GameMove?]) -> Int {
        // cpu가 이길 수 있는지 확인 후 놓기
        let cpuMoves = moves.compactMap({ $0 }).filter({ $0.player == .cpu })
        let cpuPositions = Set(cpuMoves.map({ $0.boardIndex }))
        
        if let position = getTheWinnigSpot(for: cpuPositions) {
            return position
        }
        
        // 다른 플레이어가 이길 수 있는지 확인 후 차단
        let humanMoves = moves.compactMap({ $0 }).filter({ $0.player == .player1 })
        let humanPositions = Set(humanMoves.map({ $0.boardIndex }))
        
        if let position = getTheWinnigSpot(for: humanPositions) {
            return position
        }
        
        // 중간에 놓기
        if !isSquareOccupied(in: moves, for: centerPosition) {
            return centerPosition
        }
        
        // 랜덤 놓기
        var randomPosition = Int.random(in: 0...moves.count)
        while isSquareOccupied(in: moves, for: randomPosition) {
            randomPosition = Int.random(in: 0...moves.count)
        }
        
        return randomPosition
    }
    
    private func getTheWinnigSpot(for positions: Set<Int>) -> Int? {
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(positions)
            
            if winPositions.count == 1 && !isSquareOccupied(in: moves, for: winPositions.first!) {
                return winPositions.first!
            }
        }
        
        return nil
    }
    
    private func isSquareOccupied(in moves: [GameMove?], for index: Int) -> Bool {
        moves.contains(where: { $0?.boardIndex == index })
    }
    
    private func checkForWin(in moves: [GameMove?]) -> Bool {
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == activePlayer }
        let playerPositions = playerMoves.map({ $0.boardIndex })

        for pattern in winPatterns where pattern.allSatisfy({ playerPositions.contains($0) }) {
            return true
        }
        
        return false
    }
    
    private func checkForDraw(in moves: [GameMove?]) -> Bool {
        moves.count == moves.compactMap({ $0 }).count
    }
    
    private func increaseScore() {
        if activePlayer == .player1 {
            player1Score += 1
        } else {
            player2Score += 1
        }
    }
    
    private func showAlert(for state: GameState) {
        gameNotification = state.description
        
        switch state {
            
        case .finished, .draw, .waitingForPlayer:
            let title = (state == .finished) ? "\(activePlayer.name) has won!" : state.description
            alertItem = .init(title: title, message: AppString.tryRematch)
        case .quit:
            let title = state.description
            alertItem = .init(title: title, message: "", buttonTitle: "OK")
        }
        
        showAlert = true
    }
}

extension GameViewModel {
    func processMove(for position: Int) {
        if isSquareOccupied(in: moves, for: position) { return } // 점유하고 있는지 체크
        moves[position] = .init(player: activePlayer, boardIndex: position)
        
        if checkForWin(in: moves) {
            showAlert(for: .finished)
            increaseScore()
            return
        }
        
        if checkForDraw(in: moves) {
            showAlert(for: .draw)
            return
        }
        
        switchActivePlayer()
        gameNotification = "It`s \(activePlayer.name)'s move"
        
        if gameMode == .vsCPU && activePlayer == .cpu {
            computerMove()
        }
    }
    
    func resetGame() {
        activePlayer = .player1
        moves = Array(repeating: nil, count: moves.count)
        gameNotification = "It`s \(Player.player1.name)'s move"
    }
}
