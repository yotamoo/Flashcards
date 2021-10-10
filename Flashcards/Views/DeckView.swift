//
//  DeckView.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import SwiftUI
import Combine

class DeckViewViewModel: ObservableObject {
    @Published var progress: Double = 0
    var cancellable: AnyCancellable?
    var flashcardModels: [FlashcardModel] = []
    var index: Int = 0
    
    init(flashcardRepository: FlashcardRepositoryType) {
        cancellable = flashcardRepository.getFlashcards().prefix(1).sink { _ in
            print("done")
        } receiveValue: { [weak self] in
            self?.flashcardModels = $0
        }

    }
    
    func cardViewed(_ success: Bool, model: FlashcardModel) {
        print(success ? "well done" : "next time")
        
        index += 1
        
        progress = Double(index) / Double(flashcardModels.count) * 100
        
        if model == flashcardModels.first {
            print("finished")
        }
    }
}

struct DeckView: View {
    @ObservedObject var viewModel = DeckViewViewModel(flashcardRepository: FlashcardRepository())
    
    var body: some View {
        return VStack {
            ZStack {
                ForEach(viewModel.flashcardModels) { model in
                    FlashcardView(model: model) {
                        viewModel.cardViewed($0, model: model)
                    }
                }
            }
            ProgressBarView(progress: viewModel.progress)
                .frame(width: 400, height: 30)
        }
    }
}

struct DeckView_Previews: PreviewProvider {
    static var previews: some View {
        DeckView()
    }
}
