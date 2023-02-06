//
//  GameModel.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 04.02.2023.
//

import Foundation

struct GameModel<CardContent> {
    private(set) var cards: [Card]
    
    func chose(_ card: Card) {
        
    }
    
    init(numberOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        for index in 0..<numberOfCards {
            let content = createCardContent(index)
            cards.append(Card(id: index, content: content))
        }
    }
    
    struct Card: Identifiable {
        let id: Int
        var isMatched: Bool = false
        var isSelected: Bool = false
        var isOnBoard: Bool = false
        let content: CardContent
        
        init(id: Int, content: CardContent) {
            self.id = id
            self.content = content
        }
    }
}
