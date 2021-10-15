//
//  Constants.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 14.10.21.
//

import Foundation

struct Constants {
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
              flashcards: Constants.flashcards),
        .init(id: .init(),
              title: "Deck 2",
              flashcards: Constants.flashcards),
        .init(id: .init(),
              title: "Deck 3",
              flashcards: Constants.flashcards),
    ]
}
