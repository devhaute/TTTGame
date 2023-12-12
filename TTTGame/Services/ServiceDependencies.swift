//
//  ServiceDependencies.swift
//  TTTGame
//
//  Created by kai on 12/12/23.
//

import Foundation
import Factory

extension Container {
    var firebaseService: Factory<FirebaseServiceProtocol> {
        Factory(self) { FirebaseService() }
            .shared
    }
}
