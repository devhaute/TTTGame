//
//  FCCollectionReference.swift
//  TTTGame
//
//  Created by kai on 12/11/23.
//

import Foundation
import Firebase

enum FCCollectionReference: String {
    case Game
}

func firebaseReference(_ reference: FCCollectionReference) -> CollectionReference {
    Firestore.firestore().collection(reference.rawValue)
}
