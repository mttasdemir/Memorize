//
//  ContentView.swift
//  Memorize
//
//  Created by Mustafa Taşdemir on 23.05.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            title
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFits(cardCount: viewModel.cards.count)))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card, gradient: viewModel.themeGradient)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
                //.foregroundColor(viewModel.themeColor)
            }
            Spacer()
            newGame
        }
        .padding()
    }
    
    var title: some View {
        HStack {
            Text(viewModel.themeName)
                .font(.largeTitle).fontWeight(.semibold)
            Spacer()
            Text("Score: \(viewModel.score)")
                .font(.title3)
        }
        .padding([.bottom, .leading, .trailing])
    }
    
    var newGame: some View {
        Button("New Game") {
            viewModel.newGame()
        }
    }
    
    private func widthThatBestFits(cardCount: Int) -> CGFloat {
        //CGFloat(16 * 65 / cardCount)
        return 65
    }
    
}


struct CardView: View {
    let card: MemoryGame<String>.Card
    let gradientColors: Array<Color>
    
    init(_ card: MemoryGame<String>.Card, gradient colors: [Color]) {
        self.card = card
        self.gradientColors = colors
    }
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 15)
            if card.isFaceUp {
                shape.foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else {
                shape
                    .fill(.linearGradient(colors: gradientColors, startPoint: .top, endPoint: .bottom))
                    .opacity(card.isMatched ? 0 : 1)
            }
        }
    }
    
}


struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .previewDevice("iPad (9th generation)")
            .preferredColorScheme(.light)
    }
}

