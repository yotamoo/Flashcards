//
//  DeckGalleryViewModel.swift
//  Flashcards
//
//  Created by Justyna Kleczar on 15/10/2021.
//

import Foundation
import Combine
import Common

struct DeckModelEnvironment {
    let decks: AnyPublisher<[DeckModel], Error>
}

extension DeckModelEnvironment {
    static var environment: Self {
        #if DEBUG
        .init(decks: DeckRepository().getFlashcardDecks())
        #else
        .init(decks: DeckRepository().getFlashcardDecks())
        #endif
    }

    static var mock: Self {
        .init(decks: Just(Mocks.decks)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher())
    }
}

public class DeckGalleryViewModel: ObservableObject {
    @Published var decks: [DeckModel] = []
    private var cancellable: AnyCancellable?
    
    init(environment: DeckModelEnvironment = DeckModelEnvironment.environment) {
        cancellable = environment.decks.sink(receiveCompletion: {
            print($0)
        }, receiveValue: { [weak self] in
            self?.decks = $0
        })
    }
}
