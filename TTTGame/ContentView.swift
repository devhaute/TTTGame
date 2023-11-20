//
//  ContentView.swift
//  TTTGame
//
//  Created by Tom Lee on 11/20/23.
//

import SwiftUI

struct ContentView: View {
    @ViewBuilder
    private func titleView() -> some View {
        VStack(spacing: 20) {
            Image(systemName: "number")
                .renderingMode(.original)
                .resizable()
                .frame(width: 180, height: 180)
            
            Text("Tic Tac Toe")
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
    }
    
    @ViewBuilder
    private func buttonView() -> some View {
        VStack {
            
        }
    }
    
    @ViewBuilder
    private func main() -> some View {
        VStack {
            titleView()
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
    ContentView()
}
