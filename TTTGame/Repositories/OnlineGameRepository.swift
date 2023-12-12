//
//  OnlineGameRepository.swift
//  TTTGame
//
//  Created by kai on 12/12/23.
//

import Foundation
import Combine

let localPlayerID = UUID().uuidString

protocol OnlineGameRepositoryProtocol {
    func joinGame() async
    func updateGame(_ game: Game) async
    func quitGame()
}

final class OnlineGameRepository: ObservableObject {
    @Published private(set) var game: Game?
    
    init(game: Game) {
        self.game = game
    }
    
    private func createNewGame() async {}
    private func listenForChange(in gameID: String) async {}
    private func getGame() async -> Game? { return nil }
}

extension OnlineGameRepository {
    func joinGame() async {}
    func updateGame(_ game: Game) async {
        
    }
    
    func quitGame() {
        guard game != nil else { return }
    }
}
