//
//  OvalShapeView.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 05.02.2023.
//

import SwiftUI

struct Oval: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        
        p.addRoundedRect(in: rect, cornerSize: CGSize(width: rect.width, height: rect.height))
        
        return p
    }
    
    
}

