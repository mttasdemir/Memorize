//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Mustafa Taşdemir on 4.06.2022.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    private static let animals = ["🐶", "🦊", "🦁", "🙊", "🐣", "🦉", "🦄", "🦋", "🐞", "🐢", "🐬", "🐄", "🦜", "🐏"]
    private static let foods = ["🍏", "🍊", "🍓", "🍋", "🍉", "🍒", "🥑", "🍍", "🍇", "🥂"]

    private static let vehicles = ["🚗", "🚌", "🚎", "🚓", "🚑", "🚒", "🛻", "🚚", "🚛", "🚜", "🛵", "🏍", "🛺", "🚔", "🚠", "✈️", "🚁", "🛳", "⛵️", "🛸"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 8) { pairIndex in
            vehicles[pairIndex]
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        model.cards
    }
    
    // MARK: - intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
}
