//
//  GameView.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 01.02.2023.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var game: GameViewModel
    
    var body: some View {
        NavigationStack{
            gameContent()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    if game.canAdd3Cards {
                        ToolbarItem(placement: .bottomBar) {
                            Button("Deal 3 more cards") {
                                game.add3Cards()
                            }
                        } 
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Text("Score: \(game.score)")
                    }
                    ToolbarItem(placement: .primaryAction) {
                        Menu {
                            Button {
                                game.getHint()
                            } label: {
                                HStack {
                                    Image(systemName: "wand.and.stars")
                                    Text("Hint")
                                }
                            }
                            Button {
                                game.newGame()
                            } label: {
                                HStack {
                                    Image(systemName: "gamecontroller")
                                    Text("New game")
                                    
                                }
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                        }
                        .menuStyle(.borderlessButton)
                    }
                    
                    ToolbarItem(placement: .principal) {
                        VStack{
                            Text("Set game")
                                .font(.headline)
                            Text(game.canAdd3Cards ? "\(game.cardsInDeck) cards in deck": "No more cards in deck")
                                .font(.caption)
                            
                        }
                    }
                }
        }
    }
    
    @ViewBuilder private func gameContent() -> some View {
        if !game.isTheEnd {
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                CardView(card: card, isShowMatchingResult: game.isShowMatchStatus)
                    .shadow(radius: game.hintCardIDs.contains(card.id) ? 3 : 0)
                    .onTapGesture {
                        game.chose(card)
                    }
            }
        } else {
            Text("The end!").font(.largeTitle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game:GameViewModel())
    }
}
