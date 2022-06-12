//
//  MemoryGame.swift
//  Memorize
//
//  Created by Mustafa Taşdemir on 4.06.2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: 2 * pairIndex))
            cards.append(Card(content: content, id: 2 * pairIndex + 1))
        }
    }
    
    // MARK: - Intents
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    mutating func choose(_ card: Card) {
        if let choosenCardIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[choosenCardIndex].isFaceUp
        {
            if let indexOfPotentionalMatchCard = indexOfOneAndOnlyFaceUpCard {
                if cards[indexOfPotentionalMatchCard].content == cards[choosenCardIndex].content {
                    // cards match
                    cards[indexOfPotentionalMatchCard].isMatched = true
                    cards[choosenCardIndex].isMatched = true
                }
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices { cards[index].isFaceUp = false }
                indexOfOneAndOnlyFaceUpCard = choosenCardIndex
            }
            cards[choosenCardIndex].isFaceUp = true
        }
    }
    
    // MARK: - struct Card
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        let content: CardContent
        let id: Int
    }
}
