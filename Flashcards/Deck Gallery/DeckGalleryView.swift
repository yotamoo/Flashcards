//
//  DeckGalleryView.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 13.10.21.
//

import SwiftUI
import Combine
import UI
import Common

struct DeckGalleryView: View {
    @ObservedObject var viewModel: DeckGalleryViewModel
    
    init(viewModel: DeckGalleryViewModel = .init()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.decks) { deck in
                    NavigationLink(deck.title) {
                        DeckView(viewModel: .init(title: deck.title, flashcardModels: deck.flashcards))
                    }
                }
            }
        }
    }
}

struct DeckGallery_Previews: PreviewProvider {
    static var previews: some View {
        DeckGalleryView(
            viewModel: .init(environment: .mock)
        )
    }
}

private extension DeckModelEnvironment {
    static var mock: Self {
        .init(decks: Just(Mocks.decks)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher())
    }
}
