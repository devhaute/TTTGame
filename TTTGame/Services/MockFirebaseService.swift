//
//  MockFirebaseService.swift
//  TTTGame
//
//  Created by kai on 12/14/23.
//

import Foundation
import Combine

final class MockFirebaseService: FirebaseServiceProtocol {
    
    let dummyGame: Game = .init(id: "MockID",
                                player1ID: "P1ID",
                                player1Score: 3,
                                player2ID: "P2ID",
                                player2Score: 4,
                                activePlayerID: "P1ID",
                                winnigPlayerID: "",
                                moves: Array(repeating: nil, count: 9))
    let shouldReturnNil: Bool
    
    init(shouldReturnNil: Bool = false) {
        self.shouldReturnNil = shouldReturnNil
    }
    
    func getDocuments<T: Codable>(from collection: FCCollectionReference, for playerID: String) async throws -> [T]? {
        return shouldReturnNil ? nil : [dummyGame] as? [T]
    }
    
    func listen<T: Codable>(from collection: FCCollectionReference, documentID: String) async throws -> AnyPublisher<T?, Error>{
        let subject = PassthroughSubject<T?, Error>()
        subject.send(dummyGame as? T)
        return subject.eraseToAnyPublisher()
    }
    
    func deleteDocument(with ID: String, from collection: FCCollectionReference) {}
    func saveDocument<T: EncodableIdentifiable>(data: T, to collection: FCCollectionReference) throws {}
}
