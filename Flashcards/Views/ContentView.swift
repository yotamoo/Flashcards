//
//  ContentView.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 30.09.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        DeckView(flashcardModels: [
            .init(front: "front 1", back: "back 1"),
            .init(front: "front 2", back: "back 2"),
            .init(front: "front 3", back: "back 3"),
        ])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
