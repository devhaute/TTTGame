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
            Text("\(viewModel.player1Name): \(viewModel.player1Score)")
            Spacer()
            Text("\(viewModel.player2Name): \(viewModel.player2Score)")
        }
        .foregroundColor(.white)
        .font(.title2)
        .fontWeight(.semibold)
    }
    
    @ViewBuilder
    private func gameStatus() -> some View {
        VStack {
            Text(viewModel.gameNotification)
                .font(.title2)
                .foregroundColor(.white)
        }
    }
    
    @ViewBuilder
    private func gameBoard(proxy: GeometryProxy) -> some View {
        VStack {
            LazyVGrid(columns: viewModel.columns, spacing: 10) {
                ForEach(0..<9) { index in
                    BoardCircle(geometryProxy: proxy, indicator: viewModel.moves[index]?.indicator)
                        .onTapGesture {
                            viewModel.processMove(for: index)
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
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: viewModel.alertItem!.title,
                    message: viewModel.alertItem?.message,
                    dismissButton: .default(viewModel.alertItem!.buttonTitle, action: {
                        viewModel.resetGame()
                    })
                )
            }
    }
}

#Preview {
    GameView(mode: .vsHuman)
}
