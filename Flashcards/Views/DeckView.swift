//
//  DeckView.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import SwiftUI
import Combine

class DeckViewViewModel: ObservableObject {
    var cancellable: AnyCancellable?
    var flashcardModels: [FlashcardModel] = []
    
    init(flashcardService: FlashcardServiceType) {
        cancellable = flashcardService.flashcards.prefix(1).sink { _ in
            print("done")
        } receiveValue: { [weak self] in
            self?.flashcardModels = $0
        }

    }
    
    func cardViewed(_ success: Bool, model: FlashcardModel) {
        print(success ? "well done" : "next time")
        
        if model == flashcardModels.first {
            print("finished")
        }
    }
}

class TempFlashCardService: FlashcardServiceType {
    var flashcards: AnyPublisher<[FlashcardModel], Error> {
        Just([
            FlashcardModel(id: .init(), front: "front 1", back: "back 1"),
            FlashcardModel(id: .init(), front: "front 2", back: "back 2"),
            FlashcardModel(id: .init(), front: "front 3", back: "back 3"),
        ])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

struct DeckView: View {
    let viewModel = DeckViewViewModel(flashcardService: TempFlashCardService())
    
    var body: some View {
        /*
         This does not work
         FlashcardView(model: viewModel.flashcardModels[index]) {
             viewModel.cardViewed($0)
         }
         */
        ZStack {
            ForEach(viewModel.flashcardModels) { model in
                FlashcardView(model: model) {
                    viewModel.cardViewed($0, model: model)
                }
            }
        }
    }
}

struct DeckView_Previews: PreviewProvider {
    static var previews: some View {
        DeckView()
    }
}
