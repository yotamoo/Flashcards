//
//  Mock.swift
//  Flashcards
//
//  Created by Justyna Kleczar on 15/10/2021.
//

import Foundation

struct Mocks {
    static let flashcards: [FlashcardModel] =
    [.init(id: .init(),
           front: "der Hund",
           back: "dog"),
     .init(id: .init(),
           front: "die Katze",
           back: "cat"),
     .init(id: .init(),
           front: "die Maus",
           back: "mouse"),
    ]
    
    static let decks: [DeckModel] = [
        .init(id: .init(),
              title: "Deck 1",
              flashcards: Mocks.flashcards),
        .init(id: .init(),
              title: "Deck 2",
              flashcards: Mocks.flashcards),
        .init(id: .init(),
              title: "Deck 3",
              flashcards: Mocks.flashcards),
    ]
}
