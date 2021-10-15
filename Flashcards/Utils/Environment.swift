//
//  Environment.swift
//  Flashcards
//
//  Created by Justyna Kleczar on 15/10/2021.
//

import Foundation
import Combine

struct DeckModelEnvironment {
    let decks: AnyPublisher<[DeckModel], Error>
}

extension DeckModelEnvironment {
    
    static var environment: Self {
        #if DEBUG
        .init(decks: FlashcardRepository().getFlashcardDecks())
        #else
        .init(decks: FlashcardRepository().getFlashcardDecks())
        #endif
    }
    
    static var mock: Self {
        .init(decks: Just(Mocks.decks)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher())
    }
}
