//
//  Cardify.swift
//  Memorize
//
//  Created by Mustafa Taşdemir on 28.08.2022.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isFaceUp: Bool
    func body(content: Content) -> some View {
        let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
        if isFaceUp {
            shape.foregroundColor(.white)
            shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            
        } else {
            shape
        }
        content.opacity(isFaceUp ? 1 : 0)
    }
    
    struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
    
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
