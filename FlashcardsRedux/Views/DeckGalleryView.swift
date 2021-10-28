//
//  DeckGalleryView.swift
//  FlashcardsRedux
//
//  Created by Yotam Ohayon on 28.10.21.
//

import SwiftUI
import Common
import UI

struct DeckGalleryState {
    var decks: [DeckModel]
}

struct DeckGalleryView: View {
    @ObservedObject private var store: Store<DeckGalleryState, NeverAction>

    init(store: Store<DeckGalleryState, NeverAction>) {
        self.store = store
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(store.state.decks) { deck in
                    NavigationLink(deck.title) {
                        DeckView(viewModel: .init(title: deck.title, flashcardModels: deck.flashcards))
                    }
                }
            }
        }
    }
}

struct DeckGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        DeckGalleryView(store: .init(
            name: "Deck Gallery",
            state: .init(decks: Mocks.decks),
            reducer: neverReduer())
        )
    }
}
