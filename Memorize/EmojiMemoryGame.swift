//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Mustafa Taşdemir on 4.06.2022.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    static let animals = ["🐶", "🦊", "🦁", "🙊", "🐣", "🦉", "🦄", "🦋", "🐞", "🐢", "🐬", "🐄", "🦜", "🐏"]
    static let foods = ["🍏", "🍊", "🍓", "🍋", "🍉", "🍒", "🥑", "🍍", "🍇", "🥂"]

    static let vehicles = ["🚗", "🚌", "🚎", "🚓", "🚑", "🚒", "🛻", "🚚", "🚛", "🚜", "🛵", "🏍", "🛺", "🚔", "🚠", "✈️", "🚁", "🛳", "⛵️", "🛸"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 8) { pairIndex in
            vehicles[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
