//
//  CardView.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 05.02.2023.
//

import SwiftUI

struct CardView: View {
    let card: GameViewModel.Card
    let isShowMatchingResult: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: CardViewConstants.cornerRadius)
                    .fill().foregroundColor(card.isSelected ? Color(card.content.color) : .white)
                    .opacity(card.isSelected ? CardViewConstants.stripedOpacityValue : 1)
                RoundedRectangle(cornerRadius: CardViewConstants.cornerRadius)
                    .strokeBorder(Color(card.content.color), lineWidth: CardViewConstants.lineWidth, antialiased: false)
                VStack(spacing: CardViewConstants.itemSpacing) {
                    ForEach(0..<card.content.numberOfShapes, id: \.self) { _ in
                        ZStack {
                            AnyShape(cardShape)
                                .fill(card.content.shading != .open ? Color(card.content.color) : .white)
                                .opacity(card.content.shading != .striped ? 1 : CardViewConstants.stripedOpacityValue)
                            AnyShape(cardShape)
                                .stroke(Color(card.content.color), lineWidth: CardViewConstants.lineWidth)
                        }
                        .aspectRatio(CardViewConstants.contentAspectRatio, contentMode: .fit)
                    }
                }
                .padding(geometry.size.height * CardViewConstants.shapesPaddingRatio)
                if isShowMatchingResult && card.isSelected {
                    RoundedRectangle(cornerRadius: CardViewConstants.cornerRadius)
                        .fill(card.isMatched ? .green : .red)
                        .opacity(0.8)
                }
            }
        }
    }
    
    var cardShape: any Shape {
        switch card.content.shape {
        case .squiggle:
            return Squiggle()
        case .oval:
            return Oval()
        case .diamond :
            return Diamond()
            
        }
    }
    
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .init(id: 1, content: .init(color: .mint, shape: .oval, numberOfShapes: 2, shading: .fill)), isShowMatchingResult: true)
    }
}

private struct CardViewConstants {
    static let cornerRadius: CGFloat = 8
    static let lineWidth: CGFloat = 2
    static let itemSpacing: CGFloat = 10
    static let shapesPaddingRatio: CGFloat = 0.1
    static let stripedOpacityValue: Double = 0.3
    static let contentAspectRatio: CGFloat = 3
}
