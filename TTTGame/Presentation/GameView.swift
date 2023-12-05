//
//  GameView.swift
//  TTTGame
//
//  Created by kai on 12/4/23.
//

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewMode = GameViewModel()
    
    let mode: GameMode
    
    @ViewBuilder
    private func closeButton() -> some View {
        HStack {
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Text(AppString.exit)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
            }
            .frame(width: 80, height: 40)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
            )
        }
        .padding(.bottom, 20)
    }
    
    @ViewBuilder
    private func scoreView() -> some View {
        HStack {
            Text("Player 1: 0")
            Spacer()
            Text("Player 2: 0")
        }
        .background(Color.gray)
        .foregroundColor(.white)
        .font(.title2)
        .fontWeight(.semibold)
    }
    
    @ViewBuilder
    private func gameStatus() -> some View {
        VStack {
            Text("Player 1`s move")
                .font(.title2)
        }
    }
    
    @ViewBuilder
    private func gameBoard(proxy: GeometryProxy) -> some View {
        VStack {
            LazyVGrid(columns: viewMode.columns, spacing: 10) {
                ForEach(0..<9) { _ in
                    ZStack {
                        BoardCircle(geometryProxy: proxy)
                        BoardIndicatorView(imageName: "applelogo")
                    }
                }
            }
        }
        .padding(.bottom, 10)
    }
    
    @ViewBuilder
    private func main() -> some View {
        GeometryReader { proxy in
            VStack {
                closeButton()
                scoreView()
                
                Spacer()
                
                gameStatus()
                
                Spacer()
                
                gameBoard(proxy: proxy)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 16)
        }
    }
    
    var body: some View {
        main()
    }
}

#Preview {
    GameView(mode: .vsHuman)
}
