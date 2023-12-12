//
//  FirebaseService.swift
//  TTTGame
//
//  Created by kai on 12/11/23.
//

import Foundation
import FirebaseFirestoreSwift
import Combine

public typealias EncodableIdentifiable = Encodable & Identifiable

protocol FirebaseServiceProtocol {
    func getDocuments<T: Codable>(from collection: FCCollectionReference, for playerID: String) async throws -> [T]?
    func listen<T: Codable>(from collection: FCCollectionReference, documentID: String) async throws -> AnyPublisher<T?, Error>
    func deleteDocument(with ID: String, from collection: FCCollectionReference)
    func saveDocument<T: EncodableIdentifiable>(data: T, to collection: FCCollectionReference) throws
}

final class FirebaseService: FirebaseServiceProtocol {
    func getDocuments<T: Codable>(from collection: FCCollectionReference, for playerID: String) async throws -> [T]? {
        let snapshot = try await firebaseReference(collection)
            .whereField(Constants.String.player2ID, isEqualTo: "")
            .whereField(Constants.String.player1ID, isNotEqualTo: playerID)
            .getDocuments()
        
        return snapshot.documents.compactMap { queryDocumentSnapshot -> T? in
            return try? queryDocumentSnapshot.data(as: T.self)
        }
    }
    
    func listen<T: Codable>(from collection: FCCollectionReference, documentID: String) async throws -> AnyPublisher<T?, Error>{
        let subject = PassthroughSubject<T?, Error>()
        
        let handle = firebaseReference(collection).document(documentID).addSnapshotListener { querySnapshot, error in
            if let error {
                subject.send(completion: .failure(AppError.unknownError))
                return
            }
            
            guard let document = querySnapshot else {
                subject.send(completion: .failure(AppError.badSnapshot))
                return
            }
            
            let data = try? document.data(as: T.self)
            subject.send(data)
        }
        
        return subject.handleEvents(receiveCancel: {
            handle.remove()
        }).eraseToAnyPublisher()
    }
    
    func deleteDocument(with id: String, from collection: FCCollectionReference) {
        firebaseReference(collection).document(id).delete()
    }
    
    func saveDocument<T: EncodableIdentifiable>(data: T, to collection: FCCollectionReference) throws {
        let id = data.id as? String ?? UUID().uuidString
        try firebaseReference(collection).document(id).setData(from: data)
    }
}
