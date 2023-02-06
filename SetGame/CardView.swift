//
//  CardView.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 05.02.2023.
//

import SwiftUI

struct CardView: View {
    let card: GameViewModel.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: CardViewConstants.cornerRadius)
                    .fill().foregroundColor(.white)
                RoundedRectangle(cornerRadius: CardViewConstants.cornerRadius)
                    .strokeBorder(Color(card.content.color), lineWidth: CardViewConstants.lineWidth, antialiased: false)
                VStack(spacing: CardViewConstants.itemSpacing) {
                    ForEach(0..<card.content.numberOfShapes, id: \.self) { _ in
                        ZStack {
                            AnyShape(cardShape)
                                .stroke(Color(card.content.color), lineWidth: CardViewConstants.lineWidth)
                            AnyShape(cardShape)
                                .fill(card.content.shading != "open" ? Color(card.content.color) : .white)
                                .opacity(card.content.shading != "striped" ? 1 : CardViewConstants.stripedOpacityValue)
                        }
                        .aspectRatio(CardViewConstants.contentAspectRatio, contentMode: .fit)
                    }
                }
                .padding(geometry.size.height * CardViewConstants.shapesPaddingRatio)
            }
        }
    }
    
    var cardShape: any Shape {
        if card.content.shape == "oval" {
            return Oval()
        } else if card.content.shape == "diamond" {
            return Diamond()
        } else {
            return Squiggle()
        }
    }
    
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .init(id: 1, content: .init(color: "green", shape: "diamond", numberOfShapes: 2, shading: "fill")))
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
