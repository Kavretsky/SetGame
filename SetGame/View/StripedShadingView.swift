//
//  StripedShadingView.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 10.02.2023.
//

import SwiftUI

struct StripedShadingView<ShapeView>: View where ShapeView: Shape {
    let shape: ShapeView
    let color: Color
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                HStack(spacing: 3) {
                    ForEach(0..<Int(geometry.size.width * 0.15), id: \.self) { item in
                        color
                    }
                }
                .clipShape(shape)
                AnyShape(shape)
                    .stroke(color, lineWidth: 2)
            }
            
        }
    }
}

struct StripedShadingView_Previews: PreviewProvider {
    static var previews: some View {
        StripedShadingView(shape: Squiggle(), color: .green)
    }
}
