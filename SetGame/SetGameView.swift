//
//  SetGameView.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 01.02.2023.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: GameViewModel
    
    var body: some View {
        NavigationView{
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                CardView(card: card, isShowMatchingResult: game.isShowMatchStatus)
                    .onTapGesture {
                        game.chose(card)
                    }
            }
            .navigationTitle("Set Game")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(game.canAdd3Cards ? "Deal 3 more cards" : "No more cards in deck") {
                        game.add3Cards()
                    }
                    .disabled(!game.canAdd3Cards)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Text("Score: \(game.score)")
                }
                ToolbarItem(placement: .automatic) {
                    Button("New game") {
                        game.newGame()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(game:GameViewModel())
    }
}
