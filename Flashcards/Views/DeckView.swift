//
//  DeckView.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import SwiftUI

class DeckViewViewModel: ObservableObject {
    let flashcardModels: [FlashcardModel] = [
        .init(id: .init(), front: "front 1", back: "back 1"),
        .init(id: .init(), front: "front 2", back: "back 2"),
        .init(id: .init(), front: "front 3", back: "back 3"),
    ].reversed()
    
    func cardViewed(_ success: Bool, model: FlashcardModel) {
        print(success ? "well done" : "next time")
        
        if model == flashcardModels.first {
            print("finished")
        }
    }
}

struct DeckView: View {
    let viewModel = DeckViewViewModel()
    
    var body: some View {
        /*
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
