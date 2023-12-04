//
//  HomeView.swift
//  TTTGame
//
//  Created by Tom Lee on 11/20/23.
//

import SwiftUI

struct HomeView: View {
    @ViewBuilder
    private func titleView() -> some View {
        VStack(spacing: 20) {
            Image(systemName: "number")
                .renderingMode(.original)
                .resizable()
                .frame(width: 180, height: 180)
            
            Text(AppString.appName)
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        .foregroundColor(.indigo)
        .padding(.top, 50)
    }
    
    @ViewBuilder
    private func buttonView() -> some View {
        VStack(spacing: 15) {
            ForEach(GameMode.allCases) { mode in
                Button {
                    //
                } label: {
                    Text(mode.title)
                }
                .buttonStyle(.appButton(color: mode.baseColor))
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 50)
    }
    
    @ViewBuilder
    private func main() -> some View {
        VStack {
            titleView()
            Spacer()
            buttonView()
        }
    }
    
    var body: some View {
        VStack {
            main()
        }
    }
}

#Preview {
    HomeView()
}
