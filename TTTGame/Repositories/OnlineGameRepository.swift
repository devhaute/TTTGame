//
//  OnlineGameRepository.swift
//  TTTGame
//
//  Created by kai on 12/12/23.
//

import Foundation
import Combine
import Factory

let localPlayerID = UUID().uuidString

final class OnlineGameRepository: ObservableObject {
    @Injected(\.firebaseService) private var firebaseService
    @Published private(set) var game: Game!
    
    private var cancellables = Set<AnyCancellable>()
    
    @MainActor
    private func createNewGame() async {
        game = .init(id: UUID().uuidString,
                     player1ID: localPlayerID,
                     player1Score: 0,
                     player2ID: "",
                     player2Score: 0,
                     activePlayerID: localPlayerID,
                     winnigPlayerID: "",
                     moves: Array(repeating: nil, count: 9))
        
        await self.updateGame(game)
    }
    
    @MainActor
    private func listenForChange(in gameID: String) async {
        do {
            try await firebaseService.listen(from: .Game, documentID: gameID)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error ", error.localizedDescription)
                    }
                } receiveValue: { [weak self] game in
                    self?.game = game
                }
                .store(in: &cancellables)

        } catch {
            print("Error Listening", error.localizedDescription)
        }
    }
    
    private func getGame() async -> Game? {
        return try? await firebaseService.getDocuments(from: .Game, for: localPlayerID)?.first
    }
}

extension OnlineGameRepository {
    @MainActor
    func joinGame() async {
        if let gamesToJoin: Game = await getGame() {
            game = gamesToJoin
            game.player2ID = localPlayerID
            game.activePlayerID = game.player1ID
            await updateGame(game)
            await listenForChange(in: self.game.id)
        } else {
            await createNewGame()
            await listenForChange(in: self.game.id)
        }
    }
    
    func updateGame(_ game: Game) async {
        do {
            try firebaseService.saveDocument(data: game, to: .Game)
        } catch {
            print("Error updating online game", error.localizedDescription)
        }
    }
    
    func quitGame() {
        guard game != nil else { return }
        firebaseService.deleteDocument(with: game.id, from: .Game)
    }
}
