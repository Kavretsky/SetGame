//
//  SquiggleShapeView.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 05.02.2023.
//

import SwiftUI

struct Squiggle: Shape {
    
    
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        var p = Path()
        let point1 = CGPoint(x: width * 0.252, y: height * 0.0492)
        let point2 = CGPoint(x: width * 0.4929, y: height * 0.1774)
        let point3 = CGPoint(x: width * 0.8552, y: height * 0.0492)
        let point4 = CGPoint(x: width * 0.9286, y: height * 0.6898)
        let point5 = CGPoint(x: width * 0.5125, y: height * 0.8672)
        let point6 = CGPoint(x: width * 0.1843, y: height * 0.946)
        let point7 = CGPoint(x: width * 0.0031, y: height * 0.8082)
        
        p.move(to: point1)
        p.addCurve(to: point2,
                   control1: CGPoint(x: width * 0.3606, y: height * 0.0492),
                   control2: CGPoint(x: width * 0.4471, y: height * 0.1182)
        )
        p.addCurve(to: point3,
                   control1: CGPoint(x: width * 0.5549, y: height * 0.2398),
                   control2: CGPoint(x: width * 0.674, y: height * 0.2858)
        )
        p.addCurve(to: point4,
                   control1: CGPoint(x: width * 1.0364, y: height * (-0.1872)),
                   control2: CGPoint(x: width * 1.0315, y: height * 0.4928)
        )
        p.addCurve(to: point5,
                   control1: CGPoint(x: width * 0.8552, y: height * 0.8306),
                   control2: CGPoint(x: width * 0.7708, y: height * 1.015)
        )
        p.addCurve(to: point6,
                   control1: CGPoint(x: width * 0.2469, y: height * 0.7194),
                   control2: CGPoint(x: width * 0.2333, y: height * 0.4336 * 2)
        )
        p.addCurve(to: point7,
                   control1: CGPoint(x: width * 0.137, y: height * 1.0086),
                   control2: CGPoint(x: width * 0.0345, y: height * 1.0682)
        )
        p.addCurve(to: point1,
                   control1: CGPoint(x: width * -0.015, y: height * 0.5748),
                   control2: CGPoint(x: width * 0.0178, y: height * 0.0483 * 2)
        )
        p.closeSubpath()
        
        return p
    }
    
}
