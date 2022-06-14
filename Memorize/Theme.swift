//
//  Theme.swift
//  Memorize
//
//  Created by Mustafa Taşdemir on 12.06.2022.
//

import Foundation

struct Theme {
    
    static let animals = ["🐶", "🦊", "🦁", "🙊", "🐣", "🦉", "🦄", "🦋", "🐞", "🐢", "🐬", "🐄", "🦜", "🐏"]
    static let foods = ["🍏", "🍊", "🍓", "🍋", "🍉", "🍒", "🥑", "🍍", "🍇", "🥂"]
    static let vehicles = ["🚗", "🚌", "🚎", "🚓", "🚑", "🚒", "🛻", "🚚", "🚛", "🚜", "🛵", "🏍", "🛺", "🚔", "🚠", "✈️", "🚁", "🛳", "⛵️", "🛸"]

    
    let name: ThemeType
    let gradient: Gradient
    let numberOfPairsOfCard: Int
    var emojis: Array<String>
    
    init(name: Theme.ThemeType, gradient: Gradient, numberOfPairsOfCard: Int) {
        self.name = name
        self.gradient = gradient
        switch name {
        case .vehicle:
            emojis = Theme.vehicles
            self.numberOfPairsOfCard = min(numberOfPairsOfCard, Theme.vehicles.count)
        case .animal:
            emojis = Theme.animals
            self.numberOfPairsOfCard = min(numberOfPairsOfCard, Theme.animals.count)
        case .food:
            emojis = Theme.foods
            self.numberOfPairsOfCard = min(numberOfPairsOfCard, Theme.foods.count)
        }
        emojis.shuffle()
    }
    
    func dealACard(_ index: Int) -> String {
        emojis[index]
    }
    
    enum Color: CaseIterable {
        case red, yellow, green, blue, orange, purple
        
        static func random() -> Color {
            Color.allCases.randomElement() ?? .yellow
        }
    }
    
    enum ThemeType: String, CaseIterable {
        case vehicle = "Vehicles", food = "Foods", animal = "Animals"
        
        static func random() -> ThemeType {
            ThemeType.allCases.randomElement() ?? .vehicle
        }
    }
    
    struct Gradient {
        var colors: Array<Color>
        
        init(_ colors: Color...) {
            self.colors = []
            for color in colors {
                self.colors.append(color)
            }
        }
    }
    
}
