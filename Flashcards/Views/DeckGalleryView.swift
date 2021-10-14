//
//  DeckGalleryView.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 13.10.21.
//

import SwiftUI
import Combine

struct DeckModelEnvironment {
    let decks: AnyPublisher<[DeckModel], Error>
}

let mockFlashcardRepository = FlashcardRepositoryMock()

extension DeckModelEnvironment {
    static var debug: Self {
        .init(decks: mockFlashcardRepository.getFlashcards())
    }
    
    static var release: Self {
        .init(decks: FlashcardRepository().getFlashcards())
    }
}

#if DEBUG
private let environment = DeckModelEnvironment.debug
#else
private let environment = DeckModelEnvironment.release
#endif

struct DeckModel: Identifiable, Codable, Equatable {
    let id: UUID
    let title: String
    let flashcards: [FlashcardModel]
}

class DeckGalleryViewModel: ObservableObject {
    @Published var decks: [DeckModel] = []
    private var cancellable: AnyCancellable?
    
    init(environment: DeckModelEnvironment = environment) {
        cancellable = environment.decks.sink(receiveCompletion: {
            print($0)
        }, receiveValue: { [weak self] in
            self?.decks = $0
        })
    }
}

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
                        DeckView(viewModel: .init(flashcardModels: deck.flashcards))
                    }
                }
            }
        }
    }
}

private let develop = DeckModelEnvironment(
    decks: Just(Constants.decks)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
)

struct DeckGallery_Previews: PreviewProvider {
    static var previews: some View {
        DeckGalleryView(
            viewModel: .init(environment: develop)
        )
    }
}
