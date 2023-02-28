//
//  GameModel.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 04.02.2023.
//

import Foundation

struct GameModel<CardContent: Equatable> {
    private(set) var deck: [Card]
    private(set) var board: [Card]
    private(set) var matchedCards: [Card]
    @NonNegative private(set) var score: Int
    private(set) var hintCardIDs: [Int] = []
    
    private let isCardsContentMatch: (CardContent, CardContent, CardContent) -> Bool
    
    var selectedCardsIndex: [Int] {
        board.indices.filter({board[$0].isSelected})
    }
    
    mutating func addNewCards() {
        guard !deck.isEmpty else { return }
        if isMatchStatus, board.first(where: {$0.isMatched == true}) != nil {
            for index in selectedCardsIndex {
                board[index].isSelected = false
                matchedCards.insert(board[index], at: matchedCards.startIndex)
                board[index] = deck.removeFirst()
            }
        } else {
            for _ in 0..<3 {
                board.append(deck.removeFirst())
            }
            score -= 1
        }
    }
    
    var isMatchStatus: Bool {
        selectedCardsIndex.count == 3
    }
    
    mutating func findMatchingCardIDs() {
        for firstCardIndex in 0..<(board.endIndex - 2) {
            for secondCardIndex in (firstCardIndex + 1)..<(board.endIndex - 1) {
                for thirdCardIndex in (secondCardIndex + 1)..<board.endIndex {
                    if isCardsContentMatch(board[firstCardIndex].content,board[secondCardIndex].content,board[thirdCardIndex].content) {
                        hintCardIDs = [board[firstCardIndex].id, board[secondCardIndex].id, board[thirdCardIndex].id]
                        return
                    }
                    
                }
            }
        }
        hintCardIDs = []
    }
    
    mutating func chose(_ card: Card) {
        guard var chosenIndex = board.firstIndex(where: {$0.id == card.id}),
            !board[chosenIndex].isMatched
        else {
            addNewCards()
            return
        }
        if selectedCardsIndex.count == 2 {
            let secondSelectedCardIndex = selectedCardsIndex.last!
            let firstSelectedCardIndex = selectedCardsIndex.first!
            if isCardsContentMatch(board[chosenIndex].content, board[secondSelectedCardIndex].content, board[firstSelectedCardIndex].content) {
                board[chosenIndex].isMatched = true
                board[secondSelectedCardIndex].isMatched = true
                board[firstSelectedCardIndex].isMatched = true
                score += 1
            } else {
                score -= 1
            }
        } else if selectedCardsIndex.count == 3 {
            repeat {
                let index = selectedCardsIndex.first!
                board[index].isSelected = false
                if board[index].isMatched {
                    matchedCards.insert(board.remove(at: index), at: matchedCards.startIndex)
                }
            } while !selectedCardsIndex.isEmpty
            chosenIndex = board.firstIndex(where: {$0.id == card.id})!
        }
        board[chosenIndex].isSelected.toggle()
    }
    
    init(numberOfCards: Int, createCardContent: (Int) -> CardContent, cardsMatchRule: @escaping (CardContent, CardContent, CardContent) -> Bool) {
        self.isCardsContentMatch = cardsMatchRule
        deck = []
        board = []
        matchedCards = []
        score = 0
        for index in 0..<numberOfCards {
            let content = createCardContent(index)
            deck.append(Card(id: index, content: content))
        }
        deck.shuffle()
        for _ in 0..<12 {
            board.append(deck.removeFirst())
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
