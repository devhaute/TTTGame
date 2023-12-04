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
            return AppString.vsHuman
        case .vsCPU:
            return AppString.vsCpu
        case .online:
            return AppString.online
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
