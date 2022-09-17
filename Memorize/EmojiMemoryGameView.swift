//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Mustafa Taşdemir on 23.05.2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    @State private var dealed = Set<Int>()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            deckBody
            VStack {
                title
                gameBody
                HStack {
                    restartButton
                    Spacer()
                    shuffleButton
                }
                .padding(.horizontal)
            }
        }
        .padding()
    }
    
    var title: some View {
        Text("Memorize!")
            .font(.largeTitle).fontWeight(.semibold)
            .padding(.bottom)
    }
    @Namespace private var EmojiGameNamespace
    var gameBody: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
            if isNotDealed(card) || (card.isMatched && !card.isFaceUp) {
                Rectangle().opacity(0)
            } else {
                CardView(card: card)
                    .padding([.all], 3)
                    .matchedGeometryEffect(id: card.id, in: EmojiGameNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .rotation3DEffect(Angle(degrees: card.isFaceUp ? 0 : 180), axis: (x: 0, y: 1, z: 0))
                    .zIndex(-1*Double(index(of: card)))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 1)) {
                            viewModel.choose(card)
                        }
                    }
            }
        }
        .foregroundColor(.red)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(viewModel.cards.filter(isNotDealed)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: EmojiGameNamespace)
                    .transition(AnyTransition.asymmetric(insertion: AnyTransition.scale, removal: AnyTransition.identity))
                    .zIndex(-1*Double(index(of: card)))
                    .offset(x: -1*CGFloat(index(of: card))*0.7, y: -1*CGFloat(index(of: card))*0.7)
            }
        }
        .frame(width: 60, height: 90)
        .onTapGesture {
            for card in viewModel.cards.filter(isNotDealed) {
                withAnimation(.linear.delay(Double(index(of: card)) * 0.1)) {
                    deal(card)
                }
            }
        }
        .foregroundColor(.red)
    }
    
    private func index(of card: EmojiMemoryGame.Card) -> Int {
        viewModel.cards.firstIndex { $0.id == card.id} ?? 0
    }
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealed.insert(card.id)
    }
    
    private func isNotDealed(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealed.contains(card.id)
    }
    
    var shuffleButton: some View {
        Button("Shuffle") {
            withAnimation(Animation.easeInOut(duration: 2.0)) {
                viewModel.shuffle()
            }
        }
    }
    
    var restartButton: some View {
        Button("Restart") {
            withAnimation {
                dealed.removeAll()
                viewModel.restart()
            }
        }
    }
}


struct CardView: View {
    let card: EmojiMemoryGame.Card
    @State private var animatedBonusRemainingTime: Double = 0
    var body: some View {
        GeometryReader{ geometryProxy in
            ZStack {
                Text(card.content)
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false), value: card.isMatched)
                    .font(font(in: geometryProxy.size))
                Group {
                    if card.isConsuming {
                        Pie(startAngle: Angle(degrees: 270), endAngle: Angle(degrees: -90 + (1 - animatedBonusRemainingTime) * 360))
                            .task {
                                animatedBonusRemainingTime = card.bonusRemainingTimeRatio
                                withAnimation(.linear(duration: card.bonusTime)) {
                                    animatedBonusRemainingTime = 0
                                }
                            }
                    }
                    else {
                        Pie(startAngle: Angle(degrees: 270), endAngle: Angle(degrees: -90 + (1 - card.bonusRemainingTimeRatio) * 360))
                    }
                }
                .opacity(0.4)
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

