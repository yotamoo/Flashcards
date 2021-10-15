//
//  DeckGalleryViewModel.swift
//  Flashcards
//
//  Created by Justyna Kleczar on 15/10/2021.
//

import Foundation
import Combine

class DeckGalleryViewModel: ObservableObject {
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
