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
}
