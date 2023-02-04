//
//  GameViewModel.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 02.02.2023.
//

import Foundation
import SwiftUI

class GameViewModel {
    private let model: GameModel
    
    var cards: [GameModel.Card] {
        model.activeCards
    }
    
    func choose(_ card: GameModel.Card) {
        model.choose(card)
    }
    
    init() {
        self.model = GameModel()
    }
}

extension Color {
    init(_ color: GameModel.CardColor) {
        switch color {
        case .green:
            self = Color.green
        case .yellow:
            self = Color.yellow
        case .red:
            self = Color.red
        }
    }
}
