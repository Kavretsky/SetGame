//
//  CardView.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 02.02.2023.
//

import SwiftUI

struct CardView: View {
    let card: GameModel.Card
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: CardViewConstants.cornerRadius)
                .fill().foregroundColor(.white)
            RoundedRectangle(cornerRadius: CardViewConstants.cornerRadius)
                .stroke(Color(card.color), lineWidth: CardViewConstants.lineWidth)
            switch card.symbol {
            case .diamond:
                Diamond()
            case .oval:
                RoundedRectangle(cornerRadius: 80)
            case .squiggle:
                SquiggleView()
            }
            
                
        
                
                //.stroke(Color(card.color), lineWidth: 3)
//                .aspectRatio(2, contentMode: .fit)

//            Diamond()
//                .stroke(Color(card.color), lineWidth: 3)
//                .aspectRatio(2, contentMode: .fit)
//                .padding()
//            SquiggleView()
//                .stroke()
//                .aspectRatio(2, contentMode: .fit)
//                .opacity(0.5)
//                .padding()
//                .scaleEffect(0.8)
//
//            RoundedRectangle(cornerRadius: 80)
//                .padding()
//                .aspectRatio(2, contentMode: .fit)
//                .opacity(0.5)
        }
    }
    
    @ViewBuilder
    private func shapeFor(symbol: GameModel.CardSymbol) -> some View {
        switch symbol {
        case .diamond:
            Diamond()
        case .oval:
            RoundedRectangle(cornerRadius: 80)
        case .squiggle:
            SquiggleView()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    
    static var previews: some View {
        CardView(card: .init(color: .green, symbol: .diamond, numberOfSymbols: .one, shading: .open, id: 1))
    }
}

private struct CardViewConstants {
    static let cornerRadius: CGFloat = 8
    static let lineWidth: CGFloat = 4
}
