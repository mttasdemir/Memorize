//
//  MemoryGame.swift
//  Memorize
//
//  Created by Mustafa Taşdemir on 4.06.2022.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    // MARK: - Intents
    func choose(_ card: Card) {
    }
    
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        let content: CardContent
    }
}
