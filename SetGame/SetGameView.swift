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
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
                    ForEach(game.cards, id: \.id) { card in
                        CardView(card: card, isShowMatchingResult: game.isShowMatchingResult)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.chose(card)
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Set Game")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(game.canAdd3Cards ? "Add 3 cards" : "no more cards in deck") {
                        game.add3Cards()
                    }
                    .disabled(!game.canAdd3Cards)
                    
                }
                ToolbarItem(placement: .cancellationAction) {
                    Text("Score: \(game.score)")
                }
                if !game.canAdd3Cards {
                    ToolbarItem(placement: .automatic) {
                        Button("New game") {
                            game.newGame()
                        }
                        
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
