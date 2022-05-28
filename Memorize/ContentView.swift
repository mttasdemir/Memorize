//
//  ContentView.swift
//  Memorize
//
//  Created by Mustafa Taşdemir on 23.05.2022.
//

import SwiftUI

struct ContentView: View {
    static let vehicles = ["🚗", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🛻", "🚚", "🚛", "🚜", "🛵", "🏍", "🛺", "🚔", "🚠", "✈️", "🚁", "🛳", "⛵️", "🛸"]
    static let animals = ["🐶", "🦊", "🦁", "🙊", "🐣", "🦉", "🦄", "🦋", "🐞", "🐢", "🐬", "🐄", "🦜", "🐏"]
    static let foods = ["🍏", "🍊", "🍓", "🍋", "🍉", "🍒", "🥑", "🍍", "🍇", "🥂"]
        
    @State var emojis = vehicles
    
    var body: some View {
        VStack {
            title
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFits(cardCount: emojis.count)))]) {
                    ForEach(emojis, id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
            }
            Spacer()
            themeToolbar
        }
        .padding()
    }
    
    var title: some View {
        Text("Memorize!")
            .font(.largeTitle).fontWeight(.semibold)
            .padding(.bottom)
    }
    
    var themeToolbar: some View {
        HStack(alignment: .center) {
            Button {
                let emojiCount = Int.random(in: 3..<ContentView.vehicles.count)
                emojis = Array(ContentView.vehicles.shuffled()[0...emojiCount])
            } label: {
                VStack {
                    Image(systemName: "car.fill")
                    Text("Vehicle").font(.title3)
                }
            }
            Spacer()
            Button {
                let emojiCount = Int.random(in: 3..<ContentView.animals.count)
                emojis = Array(ContentView.animals.shuffled()[0...emojiCount])
            } label: {
                VStack {
                    Image(systemName: "pawprint.fill")
                    Text("Animals").font(.title3)
                }
            }
            Spacer()
            Button {
                let emojiCount = Int.random(in: 3..<ContentView.foods.count)
                emojis = Array(ContentView.foods.shuffled()[0...emojiCount])
            } label: {
                VStack {
                    Image(systemName: "heart.fill")
                    Text("Health").font(.title3)
                }
            }
        }
        .font(.largeTitle)
        .padding(.horizontal)
    }
    
    private func widthThatBestFits(cardCount: Int) -> CGFloat {
        CGFloat(16 * 65 / cardCount)
    }
}


struct CardView: View {
    let content: String
    @State private var isFaceup: Bool = true
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 15)
            if isFaceup {
                shape.foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape
            }
        }
        .onTapGesture {
            isFaceup.toggle()
        }
    }
    
}


struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .previewDevice("iPad (9th generation)")
            .preferredColorScheme(.light)
    }
}

