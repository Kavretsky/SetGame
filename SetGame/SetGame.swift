//
//  SetGameTheme.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 04.02.2023.
//

import Foundation

struct SetGame {
    struct CardContent {
        var color: String
        var shape: String
        var numberOfShapes: Int
        var shading: String
    }
    
    private let setColors = ["red", "green", "blue"]
    private let setShapes = ["diamond", "oval", "squiggle"]
    private let setNumbersOfShapes = [1, 2 , 3]
    private let setShading = ["fill", "striped", "open"]
    
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
    
}
