//
//  ContentView.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 01.02.2023.
//

import SwiftUI

struct ContentView: View {
    let game: GameViewModel
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 70), spacing: 10)]) {
                ForEach(game.cards, id: \.id) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                    
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(game: GameViewModel())
    }
}
