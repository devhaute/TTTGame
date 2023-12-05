//
//  GameView.swift
//  TTTGame
//
//  Created by kai on 12/4/23.
//

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: GameViewModel
    
    init(mode: GameMode) {
        _viewModel = .init(wrappedValue: GameViewModel(with: mode))
    }
     
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
        .foregroundColor(.white)
        .font(.title2)
        .fontWeight(.semibold)
    }
    
    @ViewBuilder
    private func gameStatus() -> some View {
        VStack {
            Text("we are in \(viewModel.gameMode.title)")
                .font(.title2)
                .foregroundColor(.white)
        }
    }
    
    @ViewBuilder
    private func gameBoard(proxy: GeometryProxy) -> some View {
        VStack {
            LazyVGrid(columns: viewModel.columns, spacing: 10) {
                ForEach(0..<9) { _ in
                    ZStack {
                        BoardCircle(geometryProxy: proxy)
                        BoardIndicatorView(imageName: "")
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
            .background(Color.indigo)
        }
    }
    
    var body: some View {
        main()
    }
}

#Preview {
    GameView(mode: .vsHuman)
}
