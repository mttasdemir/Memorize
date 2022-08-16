//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Mustafa Taşdemir on 23.05.2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            title
            AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding([.all], 3)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .padding()
    }
    
    var title: some View {
        Text("Memorize!")
            .font(.largeTitle).fontWeight(.semibold)
            .padding(.bottom)
    }
    
}


struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader{ geometryProxy in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometryProxy.size))
                } else {
                    shape.foregroundColor(.red).opacity(card.isMatched ? 0 : 1)
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScalingFactor)
    }

    struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScalingFactor: CGFloat = 0.75
    }
    
}


struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.dark)
//        EmojiMemoryGameView(viewModel: game)
//            .previewDevice("iPad (9th generation)")
//            .preferredColorScheme(.light)
    }
}

