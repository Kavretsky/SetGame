//
//  DiamondView.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 02.02.2023.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        let bottom = CGPoint(x: rect.midX, y: rect.minY)
        let left = CGPoint(x: rect.minX, y: rect.midY)
        let top = CGPoint(x: rect.midX, y: rect.maxY)
        let right = CGPoint(x: rect.maxX, y: rect.midY)
        
        p.move(to: bottom)
        p.addLines([bottom, left, top, right, bottom])
        p.closeSubpath()
        
        return p
    }
    
    
}
