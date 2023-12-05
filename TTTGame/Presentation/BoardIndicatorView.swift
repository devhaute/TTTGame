//
//  BoardIndicatorView.swift
//  TTTGame
//
//  Created by kai on 12/5/23.
//

import SwiftUI

struct BoardIndicatorView: View {
    @State private var scale = 1.5
    
    let imageName: String
    let animationDelay: UInt64 = 100_000_000
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .frame(width: 40, height: 40)
            .scaledToFit()
            .foregroundColor(.indigo)
            .scaleEffect(scale)
            .animation(.spring(), value: scale)
            .shadow(radius: 5)
            .onChange(of: imageName) {
                Task { @MainActor in
                    scale = 2.5
                    try await Task.sleep(nanoseconds: animationDelay)
                    scale = 1.0
                }
            }
    }
}

#Preview {
    BoardIndicatorView(imageName: "applelogo")
}
