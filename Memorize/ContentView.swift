//
//  ContentView.swift
//  Memorize
//
//  Created by Mustafa Taşdemir on 23.05.2022.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["😜", "🤪", "😩", "🤫", "🚗", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🛻", "🚚", "🚛", "🚜", "🛵", "🏍", "🛺", "🚔", "🚠", "✈️", "🚁", "🛳", "⛵️", "🛸"]
    @State private var emojiCount = 20
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
            }
            Spacer()
            HStack {
                remove
                Spacer()
                add
            }
            .padding(.horizontal)
        }
        .padding()
    }
    
    var remove: some View {
        Button {
            if emojiCount > 0 {
                emojiCount -= 1
            }
        } label: { Image(systemName: "minus.circle").font(.largeTitle) }
    }
    
    var add: some View {
        Button {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: { Image(systemName: "plus.circle").font(.largeTitle) }
    }
}


struct CardView: View {
    let content: String
    @State private var isFaceup: Bool = true
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25)
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
            .preferredColorScheme(.light)
    }
}

