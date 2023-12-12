//
//  GameMode.swift
//  TTTGame
//
//  Created by kai on 12/4/23.
//

import SwiftUI

enum GameMode: CaseIterable, Identifiable {
    var id: Self { return self }
    
    case vsHuman, vsCPU, online
    
    var title: String {
        switch self {
        case .vsHuman:
            return Constants.String.vsHuman
        case .vsCPU:
            return Constants.String.vsCpu
        case .online:
            return Constants.String.online
        }
    }
    
    var baseColor: Color {
        switch self {
        case .vsHuman:
            return .indigo
        case .vsCPU:
            return .red
        case .online:
            return .green
        }
    }
}
