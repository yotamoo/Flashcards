//
//  DeckGalleryView.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 13.10.21.
//

import SwiftUI
import Combine

public struct DeckGalleryView: View {
    @ObservedObject var viewModel: DeckGalleryViewModel
    
    public init(viewModel: DeckGalleryViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
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
