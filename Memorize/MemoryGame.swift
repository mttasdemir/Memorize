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
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: 2 * pairIndex))
            cards.append(Card(content: content, id: 2 * pairIndex + 1))
        }
    }
    
    // MARK: - Intents
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var faceUpIndicies = [Int]()
            for index in cards.indices {
                if cards[index].isFaceUp {
                    faceUpIndicies.append(index)
                }
            }
            if faceUpIndicies.count == 1 {
                return faceUpIndicies.first
            } else {
                return nil
            }
        }
        set {
            for index in cards.indices {
                if index == newValue {
                    cards[index].isFaceUp = true
                } else {
                    cards[index].isFaceUp = false
                }
            }
        }
    }
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
                cards[choosenCardIndex].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = choosenCardIndex
            }
        }
    }
    
    // MARK: - struct Card
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
    }
}
