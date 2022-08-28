//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Mustafa Taşdemir on 15.08.2022.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    let items: [Item]
    let aspectRatio: CGFloat
    @ViewBuilder var content: (Item) -> ItemView

    var body: some View {
        GeometryReader { geometryproxy in
            let width: CGFloat = widthThatFits(itemsCount: items.count, aspectRatio: aspectRatio, in: geometryproxy.size)
            LazyVGrid(columns: [gridItem(minWidth: width)], spacing: 0) {
                ForEach(items) { item in
                    content(item).aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    private func gridItem(minWidth: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: minWidth))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func widthThatFits(itemsCount: Int, aspectRatio: CGFloat, in size: CGSize) -> CGFloat {
        var columnCount = 1
        var rowCount = itemsCount
        
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / aspectRatio
            if itemHeight * CGFloat(rowCount) < size.height {
                break
            }
            columnCount += 1
            rowCount = Int(ceil(Double(itemsCount) / Double(columnCount)))
            
        } while columnCount < itemsCount
        
        return floor(size.width / CGFloat(columnCount))
        
    }
    
}



//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
