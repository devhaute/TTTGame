//
//  AlertItem.swift
//  TTTGame
//
//  Created by kai on 12/7/23.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID().uuidString
    let title: Text
    let message: Text
    let buttonTitle: Text
    
    init(title: String, message: String, buttonTitle: String = Constants.String.rematch) {
        self.title = Text(title)
        self.message = Text(message)
        self.buttonTitle = Text(buttonTitle)
    }
}
