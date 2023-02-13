//
//  GameModel.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 04.02.2023.
//

import Foundation

struct GameModel<CardContent: Equatable> {
    private(set) var cards: [Card]
    private(set) var cardsOnBoard: [Card]
    @NonNegative private(set) var score: Int
    private(set) var hintCardIDs: [Int] = []
    
    private let isCardsContentMatch: (CardContent, CardContent, CardContent) -> Bool
    
    var selectedCardsIndex: [Int] {
        cardsOnBoard.indices.filter({cardsOnBoard[$0].isSelected})
    }
    
    mutating func addNewCards() {
        guard !cards.isEmpty else { return }
        if isMatchStatus, cardsOnBoard.first(where: {$0.isMatched == true}) != nil {
            for index in selectedCardsIndex {
                cardsOnBoard[index] = cards.removeFirst()
            }
        } else {
            for _ in 0..<3 {
                cardsOnBoard.append(cards.removeFirst())
            }
            score -= 1
        }
    }
    
    var isMatchStatus: Bool {
        selectedCardsIndex.count == 3
    }
    
    mutating func findMatchingCardIDs() {
        for firstCardIndex in 0..<(cardsOnBoard.endIndex - 2) {
            for secondCardIndex in (firstCardIndex + 1)..<(cardsOnBoard.endIndex - 1) {
                for thirdCardIndex in (secondCardIndex + 1)..<cardsOnBoard.endIndex {
                    if isCardsContentMatch(cardsOnBoard[firstCardIndex].content,cardsOnBoard[secondCardIndex].content,cardsOnBoard[thirdCardIndex].content) {
                        hintCardIDs = [cardsOnBoard[firstCardIndex].id, cardsOnBoard[secondCardIndex].id, cardsOnBoard[thirdCardIndex].id]
                        return
                    }
                    
                }
            }
        }
        hintCardIDs = []
    }
    
    mutating func chose(_ card: Card) {
        guard var chosenIndex = cardsOnBoard.firstIndex(where: {$0.id == card.id}),
            !cardsOnBoard[chosenIndex].isMatched
        else {
            addNewCards()
            return
        }
        if selectedCardsIndex.count == 2 {
            let secondSelectedCardIndex = selectedCardsIndex.last!
            let firstSelectedCardIndex = selectedCardsIndex.first!
            if isCardsContentMatch(cardsOnBoard[chosenIndex].content, cardsOnBoard[secondSelectedCardIndex].content, cardsOnBoard[firstSelectedCardIndex].content) {
                cardsOnBoard[chosenIndex].isMatched = true
                cardsOnBoard[secondSelectedCardIndex].isMatched = true
                cardsOnBoard[firstSelectedCardIndex].isMatched = true
                score += 1
            } else {
                score -= 1
            }
        } else if selectedCardsIndex.count == 3 {
            repeat {
                let index = selectedCardsIndex.first!
                cardsOnBoard[index].isSelected = false
                if cardsOnBoard[index].isMatched {
                    if !cards.isEmpty {
                        cardsOnBoard[index] = cards.removeFirst()
                    } else {
                        cardsOnBoard.remove(at: index)
                    }
                }
            } while !selectedCardsIndex.isEmpty
            chosenIndex = cardsOnBoard.firstIndex(where: {$0.id == card.id})!
        }
        cardsOnBoard[chosenIndex].isSelected.toggle()
    }
    
    init(numberOfCards: Int, createCardContent: (Int) -> CardContent, cardsMatchRule: @escaping (CardContent, CardContent, CardContent) -> Bool) {
        self.isCardsContentMatch = cardsMatchRule
        cards = []
        cardsOnBoard = []
        score = 0
        for index in 0..<numberOfCards {
            let content = createCardContent(index)
            cards.append(Card(id: index, content: content))
        }
        cards.shuffle()
        for _ in 0..<12 {
            cardsOnBoard.append(cards.removeFirst())
        }
    }
    
    struct Card: Identifiable {
        
        let id: Int
        var isMatched: Bool = false
        var isSelected: Bool = false
        let content: CardContent
        
        init(id: Int, content: CardContent) {
            self.id = id
            self.content = content
        }
    }
}

extension GameModel {
    @propertyWrapper
    struct NonNegative {
        private var number = 0
        var wrappedValue: Int {
            get { return number }
            set { number = max(newValue, 0) }
        }
    }
}
