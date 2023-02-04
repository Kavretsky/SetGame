//
//  GameModel.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 02.02.2023.
//

import Foundation

struct GameModel {
    private var cards: [Card]
    private(set) var activeCards: [Card]
    
    func choose(_ card: Card) {
        
    }
    
    
    
    struct Card {
        let color: CardColor
        let symbol: CardSymbol
        let numberOfSymbols: CardNumberOfSymbols
        let shading: CardShading
        var isMatched: Bool = false
        var isSelected: Bool = false
        let id: Int
    }
    
    init() {
        cards = []
        activeCards = []
        var id = 0
        for color in CardColor.allCases {
            for symbol in CardSymbol.allCases {
                for numberOfSymbols in CardNumberOfSymbols.allCases {
                    for shading in CardShading.allCases {
                        id += 1
                        let newCard = Card(color: color, symbol: symbol, numberOfSymbols: numberOfSymbols, shading: shading, id: id)
                        cards.append(newCard)
                    }
                }
            }
        }
        //Mark: Bagus
        cards = cards.shuffled()
        for index in 0..<12 {
            activeCards.append(cards.removeLast())
            print("color:\(activeCards[index].color), sybmol: \(activeCards[index].symbol), numberOfSymbols: \(activeCards[index].numberOfSymbols), shading: \(activeCards[index].shading), id:\(activeCards[index].id)")
        }
        
        
    }
}

extension GameModel {
    enum CardColor: CaseIterable {
        case green
        case yellow
        case red
    }
         
    enum CardSymbol: CaseIterable {
        case diamond
        case oval
        case squiggle
    }
    
    enum CardNumberOfSymbols: CaseIterable {
        case one
        case two
        case three
    }
    
    enum CardShading: CaseIterable {
        case solid
        case striped
        case open
    }
}
