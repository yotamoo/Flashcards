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
    static var live: Self {
        .init(decks: DeckRepository().decks)
    }
}

class DeckGalleryViewModel: ObservableObject {
    @Published var decks: [DeckModel] = []
    private var cancellable: AnyCancellable?
    
    init(environment: DeckModelEnvironment = .live) {
        cancellable = environment.decks.sink(
            receiveCompletion: { _ in },
            receiveValue: { [weak self] in
                self?.decks = $0
            }
        )
    }
}
