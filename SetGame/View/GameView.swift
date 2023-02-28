//
//  GameView.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 01.02.2023.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var game: GameViewModel
    
    @Namespace private var dealingNameSpace
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                header
                gameContent()
                HStack {
                    deck
                    Spacer()
                    hintButton
                    Spacer()
                    discardPile
                }
                .padding(.horizontal)
            }
        }
    }
    
    @ViewBuilder private var hintButton: some View {
        Button {
            withAnimation {
                game.getHint()
            }
        } label: {
            HStack {
                Image(systemName: "wand.and.stars")
                Text("Hint")
            }
        }
    }
    
    
    @ViewBuilder private func gameContent() -> some View {
        if !game.isTheEnd {
            AspectVGrid(items: game.board, aspectRatio: CardConstants.aspectRation) { card in
                CardView(card: card, isShowMatchingResult: game.isShowMatchStatus)
                    .shadow(color: .green, radius: game.hintCardIDs.contains(card.id) ? 5 : 0)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .onTapGesture {
                        withAnimation {
                            game.chose(card)
                        }
                        
                    }
            }
        } else {
            Text("The end!").font(.largeTitle)
        }
    }
    
    var header: some View {
        HStack {
            Text("Score: \(game.score)")
            Spacer()
            Text("Set game")
                .fontWeight(.bold)
            Spacer()
            Button {
                game.newGame()
            } label: {
                
                Text("New game")
                
            }
        }
        .padding()
    }
    
    var discardPile: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: 8).foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.814))
            ForEach(game.discardPile) { card in
                CardView(card: card, isShowMatchingResult: false)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .zIndex(zIndex(of: card, in: game.discardPile))
                    .rotationEffect(rotationAngle(for: card))
            }
        }
        .frame(width: CardConstants.deckWidth, height: CardConstants.deckHeight)
    }
    
    var deck: some View {
        ZStack {
            ForEach(game.deck) { card in
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: CardConstants.deckWidth, height: CardConstants.deckHeight)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .zIndex(zIndex(of: card, in: game.deck))
                    .rotationEffect(rotationAngle(for: card))
                    .shadow(radius: 0.5)
                    .onTapGesture {
                        withAnimation {
                            game.deal3MoreCards()
                        }
            }
        }
        .foregroundColor(CardConstants.cardColor)  
        }
    }
    
    private func rotationAngle(for card: GameViewModel.Card) -> Angle {
        Angle(degrees: Double(card.id % 30 - 15))
    }
    
    private func zIndex(of card: GameViewModel.Card, in array: [GameViewModel.Card]) -> Double {
        -Double(array.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    
    
    
//    private func dealAndDiscardAnimation(for card: GameViewModel.Card, in array: [GameViewModel.Card]) -> Animation {
//        var delay = 0.0
//        if let index = array.firstIndex(where: {$0.id == card.id}) {
//            delay = Double(index) * (CardConstants.totalAnimationDuration / Double(array.count))
//        }
//        return Animation.easeIn(duration: CardConstants.totalAnimationDuration).delay(delay)
//    }
    
    private struct CardConstants {
        static let cardColor: Color = .green
        static let deckHeight: CGFloat = 90
        static let aspectRation: CGFloat = 2/3
        static let deckWidth = deckHeight * aspectRation
        static let totalAnimationDuration:Double = 1
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game:GameViewModel())
    }
}
