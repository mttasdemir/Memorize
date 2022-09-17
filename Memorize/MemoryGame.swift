//
//  MemoryGame.swift
//  Memorize
//
//  Created by Mustafa Taşdemir on 4.06.2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: 2 * pairIndex))
            cards.append(Card(content: content, id: 2 * pairIndex + 1))
        }
        cards.shuffle()
    }
    
    // MARK: - Intents
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
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
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    // MARK: - struct Card
    struct Card: Identifiable {
        var isFaceUp = false {
            willSet {
                newValue ? startTimer() : stopTimer()
            }
        }
        var isMatched = false {
            willSet {
                if newValue {
                    stopTimer()
                }
            }
        }
        let content: CardContent
        let id: Int
        var pie = Pie()
        
        let bonusLimit: Double = 10
        var bonusTime: Double = 10
        var startTime: TimeInterval = 0
        var stopTime: TimeInterval = 0
        var timerStarted: Bool = false

        mutating func startTimer() {
            timerStarted.toggle()
            startTime = Date.now.timeIntervalSince1970
        }
        
        mutating func stopTimer() {
            if timerStarted {
                timerStarted.toggle()
                stopTime = Date.now.timeIntervalSince1970
                bonusTime = max(0, bonusTime - (stopTime - startTime))
            }
        }
        
        var isConsuming: Bool {
            isFaceUp && !isMatched && bonusTime > 0
        }
        
        var bonusRemainingTimeRatio: Double {
            bonusTime / bonusLimit
        }
        
    }
}


extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
