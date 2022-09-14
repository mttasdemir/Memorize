//
//  Cardify.swift
//  Memorize
//
//  Created by Mustafa Taşdemir on 28.08.2022.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    var animatableData: Double {
        get {
            angle
        }
        set {
            angle = newValue
        }
    }
    var angle: Double
    var isFaceUp: Bool
    
    init(isFaceUp: Bool) {
        self.isFaceUp = isFaceUp
        self.angle = isFaceUp ? 0: 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if angle < 90 {
                shape.foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                
            } else {
                ZStack {
                    shape
                    shape.stroke().foregroundColor(.black)
                }
            }
            content.opacity(angle < 90 ? 1 : 0)
        }
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
