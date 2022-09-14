//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Mustafa Taşdemir on 4.06.2022.
//

import SwiftUI
import Combine


class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    private static let animals = ["🐶", "🦊", "🦁", "🙊", "🐣", "🦉", "🦄", "🦋", "🐞", "🐢", "🐬", "🐄", "🦜", "🐏"]
    private static let foods = ["🍏", "🍊", "🍓", "🍋", "🍉", "🍒", "🥑", "🍍", "🍇", "🥂"]

    private static let vehicles = ["🚗", "🚌", "🚎", "🚓", "🚑", "🚒", "🛻", "🚚", "🚛", "🚜", "🛵", "🏍", "🛺", "🚔", "🚠", "✈️", "🚁", "🛳", "⛵️", "🛸", "🚲"]
    
    private static func createMemoryGame(ofCardPairs: Int) -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: ofCardPairs) { pairIndex in
            vehicles[pairIndex]
        }
    }
    
    @Published private var model = createMemoryGame(ofCardPairs: 4)
    
    var cards: Array<Card> {
        model.cards
    }
    
    // MARK: - intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame(ofCardPairs: 4);
    }
        
    private var timer: Timer.TimerPublisher
    private var cancellable: AnyCancellable?
    
    init() {
        timer = Timer.publish(every: Constants.timeInterval, on: RunLoop.main, in: RunLoop.Mode.common)
        start()
    }
    
    func start() {
        cancellable =
        timer.autoconnect()
            .sink { time in
                self.handler()
            }
    }
    
    func stop() {
        cancellable?.cancel()
    }
    
    func handler() {
        for indice in model.cards.indices {
            let card = cards[indice]
            if card.isFaceUp && !card.isMatched {
                model.cards[indice].pie.setArc(by: Constants.angleOfPie )
            }
        }
    }
    
    struct Constants {
        static let timeInterval = 0.01
        static let angleOfPie = (360 / 5) * timeInterval
    }
    
}

