//
//  GameViewModelTests.swift
//  TTTGameTests
//
//  Created by Tom Lee on 11/20/23.
//

import XCTest
@testable import TTTGame

final class GameViewModelTests: XCTestCase {
    var sut = GameViewModel(with: .vsHuman, onlineRepository: OnlineGameRepository())
    
    func test_restGameSetsTheActivePlayerToPlayer1() {
        sut.resetGame()
        XCTAssertEqual(sut.activePlayer, .player1)
    }
    
    func test_resetGameSetsTheMovesToNineNilObjects() {
        sut.resetGame()
        
        for index in 0...8 {
            XCTAssertNil(sut.moves[index])
        }
    }
    
    func test_resetGameSetsGameNotificationToP1Turn() {
        sut.resetGame()
        XCTAssertEqual(sut.gameNotification, "It`s \(sut.activePlayer.name)'s move")
    }
    
    func test_processMovesWillShowFinishAlert() {
        for index in 0..<9 {
            sut.processMove(for: index)
        }
        
        XCTAssertEqual(sut.gameNotification, Constants.String.gameHasFinished)
    }
    
    func test_processMovesWillReturnForOccupiedSquare() {
        sut.processMove(for: 0)
        sut.processMove(for: 0)
        
        let activeMovesCount = sut.moves.compactMap({ $0 }).count
        XCTAssertEqual(activeMovesCount, 1)
    }
    
    func test_Player1WinWillIncreaseTheScore() {
        player1WillWin()
        XCTAssertEqual(sut.player1Score, 1)
    }
    
    func test_Player2WinWillIncreaseTheScore() {
        player2WillWin()
        XCTAssertEqual(sut.player2Score, 1)
    }
    
    func test_drawWillShowNotification() {
        playerWillDraw()
        XCTAssertTrue(sut.showAlert)
        XCTAssertEqual(sut.gameNotification, Constants.String.draw)
    }
    
    func test_CPUWillTakeTheMiddleSpot() {
        let expectation = expectation(description: "컴퓨터 이동을 기다립니다.")
        
        sut = .init(with: .vsCPU, onlineRepository: OnlineGameRepository())
        sut.processMove(for: 0)
        
        Task {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.5)
        XCTAssertNotNil(sut.moves[4])
    }
}

// Helpers
extension GameViewModelTests {
    private func player1WillWin() {
        sut.processMove(for: 0)
        sut.processMove(for: 2)
        sut.processMove(for: 3)
        sut.processMove(for: 5)
        sut.processMove(for: 6)
    }
    
    private func player2WillWin() {
        sut.processMove(for: 2)
        sut.processMove(for: 0)
        sut.processMove(for: 5)
        sut.processMove(for: 3)
        sut.processMove(for: 4)
        sut.processMove(for: 6)
    }
    
    private func playerWillDraw() {
        sut.processMove(for: 0)
        sut.processMove(for: 1)
        sut.processMove(for: 2)
        sut.processMove(for: 4)
        sut.processMove(for: 3)
        sut.processMove(for: 5)
        sut.processMove(for: 7)
        sut.processMove(for: 6)
        sut.processMove(for: 8)
    }
}
