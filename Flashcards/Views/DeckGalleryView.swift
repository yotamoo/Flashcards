//
//  DeckGalleryView.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 13.10.21.
//

import SwiftUI
import Combine

struct DeckGalleryView: View {
    @ObservedObject var viewModel: DeckGalleryViewModel
    
    init(viewModel: DeckGalleryViewModel = DeckGalleryViewModel()) {
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
            viewModel: .init(environment: DeckModelEnvironment.mock)
        )
    }
}
