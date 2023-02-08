//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 04.02.2023.
//

import Foundation
import SwiftUI



class GameViewModel: ObservableObject {
    typealias Card = GameModel<SetGame.CardContent>.Card
    
    private static func createGame(cardContent: [SetGame.CardContent]) -> GameModel<SetGame.CardContent> {
        let numberOfCards = cardContent.count
        return GameModel(numberOfCards: numberOfCards) { index in
            cardContent[index]
        } cardsMatchRule: { card1, card2, card3 in
            let colorsSet: Set<String> = [card1.color, card2.color, card3.color]
            let shapeSet: Set<String> = [card1.shape, card2.shape, card3.shape]
            let shadingSet: Set<String> = [card1.shading, card2.shading, card3.shading]
            let numberOfShapesSet: Set<Int> = [card1.numberOfShapes, card2.numberOfShapes, card3.numberOfShapes]
            return colorsSet.count != 2 && shapeSet.count != 2 && shadingSet.count != 2 && numberOfShapesSet.count != 2
        }
    }
    
    
    private var game: SetGame
    
    @Published private var model: GameModel<SetGame.CardContent>
    
    var cards: [Card] {
        return model.cardsOnBoard
    }
    var score: Int {
        model.score
    }
    
    init() {
        self.game = SetGame()
        self.model = GameViewModel.createGame(cardContent: game.content)
    }
    
    func chose(_ card: Card){
        model.chose(card)
    }
    
    var canAdd3Cards: Bool {
        !model.cards.isEmpty
    }
    
    func add3Cards() {
        model.addNewCards()
    }
    
    var isShowMatchingResult: Bool {
        model.selectedCardsIndex.count == 3
    }
    
    func newGame() {
        self.game = SetGame()
        self.model = GameViewModel.createGame(cardContent: game.content)
    }
}

extension Color {
    init(_ name: String) {
        switch name {
        case "mint":
            self = Color.mint
        case "purple":
            self = Color.purple
        case "blue":
            self = Color.blue
        default:
            self = Color.white
        }
    }
}
