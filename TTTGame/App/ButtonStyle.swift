//
//  ButtonStyle.swift
//  TTTGame
//
//  Created by kai on 12/4/23.
//

import SwiftUI

struct AppButtonStyle: ButtonStyle {
    private let color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding()
            .background(color)
            .clipShape(Capsule())
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .shadow(radius: 8, x: 2, y: 4)
    }
}

extension ButtonStyle where Self == AppButtonStyle  {
    static func appButton(color: Color) -> AppButtonStyle {
        AppButtonStyle(color: color)
    }
}
