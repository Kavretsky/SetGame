//
//  ShapeBuilderView.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 03.02.2023.
//

import SwiftUI

struct ShapeBuilderView: View, ShapeStyle {
    let cardShape: GameModel.CardSymbol
    
    var body: some View {
        switch cardShape {
        case .diamond:
            Diamond()
        case .oval:
            RoundedRectangle(cornerRadius: 80)
        case .squiggle:
            SquiggleView()
        }
    }
}
