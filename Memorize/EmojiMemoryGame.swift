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
        self.theme = Theme(name: .random(), gradient: Theme.Gradient(.random(), .random(), .random()), numberOfPairsOfCard: Int.random(in: numberOfEmojiInRange))
        self.model = MemoryGame(numberOfPairsOfCards: theme.numberOfPairsOfCard, createCardContent: theme.dealACard)
    }
    
    var themeGradient: [Color] {
        var result = [Color]()
        for color in theme.gradient.colors {
            switch color {
            case .red: result.append(.red)
            case .yellow: result.append(.yellow)
            case .green: result.append(.green)
            case .blue: result.append(.blue)
            case .orange: result.append(.orange)
            case .purple: result.append(.purple)
            }
        }
        return result
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
        self.theme = Theme(name: .random(), gradient: Theme.Gradient(.random(), .random()), numberOfPairsOfCard: Int.random(in: numberOfEmojiInRange))
        self.model = MemoryGame(numberOfPairsOfCards: theme.numberOfPairsOfCard, createCardContent: theme.dealACard)
    }
}
