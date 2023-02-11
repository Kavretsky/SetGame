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
                    .foregroundColor(card.isSelected ? Color(card.content.color) : .white)
                    .opacity(card.isSelected ? CardViewConstants.stripedOpacityValue : 1)
                RoundedRectangle(cornerRadius: CardViewConstants.cornerRadius)
                    .strokeBorder(Color(card.content.color), lineWidth: CardViewConstants.lineWidth, antialiased: false)
                VStack(spacing: CardViewConstants.itemSpacing) {
                    ForEach(0..<card.content.numberOfShapes, id: \.self) { _ in
                        filledCardShape
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
    
    private var cardShape: any Shape {
        switch card.content.shape {
        case .squiggle:
            return Squiggle()
        case .oval:
            return Oval()
        case .diamond :
            return Diamond()

        }
    }
    
    @ViewBuilder private var filledCardShape: some View {
        switch card.content.shading {
        case .striped:
            StripedShadingView(shape: AnyShape(cardShape), color: Color(card.content.color))
        case .open:
            AnyShape(cardShape)
                .stroke(Color(card.content.color), lineWidth: CardViewConstants.lineWidth)
        case .fill:
            AnyShape(cardShape)
                .fill(Color(card.content.color))
        }
        
    }
    
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .init(id: 1, content: .init(color: .mint, shape: .oval, numberOfShapes: 2, shading: .striped)), isShowMatchingResult: true)
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
