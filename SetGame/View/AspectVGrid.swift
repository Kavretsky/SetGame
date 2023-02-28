//
//  AspectVGrid.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 09.02.2023.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View  where ItemView: View, Item: Identifiable{
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                HStack {
                    let width: CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio)
                    LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                        ForEach(items) { item in
                            content(item).aspectRatio(aspectRatio, contentMode: .fit)
                                .padding(4)
                        }
                    }
                }
//                .padding()
                Spacer(minLength: 0)
            }
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        let width1 = width < 60 ? 60 : width
        var gridItem = GridItem(.adaptive(minimum: width1))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
            var columnCount = 1
            var rowCount = itemCount
            repeat {
                let itemWidth = (size.width)  / CGFloat(columnCount)
                let itemHeight = itemWidth / itemAspectRatio
                if  CGFloat(rowCount) * itemHeight < (size.height) {
                    break
                }
                columnCount += 1
                rowCount = (itemCount + (columnCount - 1)) / columnCount
            } while columnCount < itemCount
            if columnCount > itemCount {
                columnCount = itemCount
            }
            return floor(size.width / CGFloat(columnCount))
        }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
