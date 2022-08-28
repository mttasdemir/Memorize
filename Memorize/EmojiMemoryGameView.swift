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
                        .padding([.all], 3)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
            .foregroundColor(.red)
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
                Text(card.content)
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false), value: card.isMatched)
                    .font(font(in: geometryProxy.size))
                Pie().opacity(0.4)
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScalingFactor)
    }

    struct DrawingConstants {
        static let fontScalingFactor: CGFloat = 0.65
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

