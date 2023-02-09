//
//  SetGameTheme.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 04.02.2023.
//

import Foundation

struct SetGame {
    struct CardContent: Equatable {
        var color: SetColor
        var shape: SetShape
        var numberOfShapes: Int
        var shading: SetShading
    }
    
    private let setColors: [SetColor] = [.mint, .blue, .purple]
    private let setShapes: [SetShape] = [.diamond, .oval, .squiggle]
    private let setNumbersOfShapes = [1, 2 , 3]
    private let setShading: [SetShading] = [.fill, .striped, .open]
    
    private(set) var content: [CardContent]
    
    init() {
        var content: [CardContent] = []
        for color in setColors {
            for shape in setShapes {
                for numbersOfShape in setNumbersOfShapes {
                    for shading in setShading {
                        content.append(CardContent(color: color, shape: shape, numberOfShapes: numbersOfShape, shading: shading))
                    }
                }
            }
        }
        self.content = content
    }
    
    enum SetShape {
        case diamond, oval, squiggle
    }
    
    enum SetColor {
        case mint, purple, blue
    }
    
    enum SetShading {
        case fill, striped, open
    }
    
}
