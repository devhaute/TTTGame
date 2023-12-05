//
//  BoardCircle.swift
//  TTTGame
//
//  Created by kai on 12/4/23.
//

import SwiftUI

struct BoardCircle: View {
    var geometryProxy: GeometryProxy
    private let sizeDivider: CGFloat = 3
    private let padding: CGFloat = 15
    
    var body: some View {
        Circle()
            .fill(.white)
            .frame(
                width: geometryProxy.size.width / sizeDivider - padding,
                height: geometryProxy.size.width / sizeDivider - padding
            )
    }
}

#Preview {
    GeometryReader { proxy in
        BoardCircle(geometryProxy: proxy)
    }
}
