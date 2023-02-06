//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 04.02.2023.
//

import Foundation
import SwiftUI



class GameViewModel {
    typealias Card = GameModel<SetGame.CardContent>.Card
    
    private static func createGame(cardContent: [SetGame.CardContent]) -> GameModel<SetGame.CardContent> {
        let numberOfCards = cardContent.count
        return GameModel(numberOfCards: numberOfCards) { index in
            cardContent[index]
        }
    }
    private let game: SetGame
    
    private let model: GameModel<SetGame.CardContent>
    
    var cards: [Card] {
        return model.cards
    }
    
    init() {
        self.game = SetGame()
        self.model = GameViewModel.createGame(cardContent: game.content)
    }
    
}

extension Color {
    init(_ name: String) {
        switch name {
        case "red":
            self = Color.red
        case "green":
            self = Color.green
        case "blue":
            self = Color.blue
        default:
            self = Color.white
        }
    }
}
