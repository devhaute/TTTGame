//
//  BoardCircle.swift
//  TTTGame
//
//  Created by kai on 12/4/23.
//

import SwiftUI

struct BoardCircle: View {
    @State private var scale = 1.5
    
    let geometryProxy: GeometryProxy
    let indicator: BoardCircleIndicator?
    
    private let sizeDivider: CGFloat = 3
    private let padding: CGFloat = 15
    private let animationDelay: UInt64 = 100_000_000
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.white)
                .frame(
                    width: geometryProxy.size.width / sizeDivider - padding,
                    height: geometryProxy.size.width / sizeDivider - padding
                )
            
            Image(systemName: indicator?.rawValue ?? "")
                .resizable()
                .frame(width: 40, height: 40)
                .scaledToFit()
                .foregroundColor(.indigo)
                .scaleEffect(scale)
                .animation(.spring(), value: scale)
                .shadow(radius: 5)
                .onChange(of: indicator) {
                    Task { @MainActor in
                        scale = 2.5
                        try await Task.sleep(nanoseconds: animationDelay)
                        scale = 1.0
                    }
                }
        }
    }
}

#Preview {
    GeometryReader { proxy in
        BoardCircle(geometryProxy: proxy, indicator: .xmark)
    }
}
