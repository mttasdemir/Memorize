//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Mustafa Taşdemir on 4.06.2022.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    let numberOfEmojiInRange: ClosedRange = .init(uncheckedBounds: (4, 24))
    @Published private var model: MemoryGame<String>
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    private var theme: Theme
    
    init() {
        self.theme = Theme(name: .random(), color: .random(), numberOfPairsOfCard: Int.random(in: numberOfEmojiInRange))
        self.model = MemoryGame(numberOfPairsOfCards: theme.numberOfPairsOfCard, createCardContent: theme.dealACard)
    }
    
    var themeColor: Color {
        switch theme.color {
        case .red: return .red
        case .yellow: return .yellow
        case .green: return .green
        case .blue: return .blue
        }
    }
    
    var themeName: String {
        theme.name.rawValue
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        self.theme = Theme(name: .random(), color: .random(), numberOfPairsOfCard: Int.random(in: numberOfEmojiInRange))
        self.model = MemoryGame(numberOfPairsOfCards: theme.numberOfPairsOfCard, createCardContent: theme.dealACard)
    }
}
