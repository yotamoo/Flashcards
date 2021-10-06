//
//  DeckView.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import SwiftUI

class DeckViewViewModel: ObservableObject {
    @Published var flashcardModels: [FlashcardModel] = [
        .init(id: .init(), front: "front 1", back: "back 1"),
        .init(id: .init(), front: "front 2", back: "back 2"),
        .init(id: .init(), front: "front 3", back: "back 3"),
    ]
}

struct DeckView: View {
    @ObservedObject var viewModel = DeckViewViewModel()
    @State var index = 0
    
    var body: some View {
        ZStack {
            ForEach(viewModel.flashcardModels) { model in
                FlashcardView(model: model) {
                    print($0 ? "well done" : "next time")
                    if index + 1 < viewModel.flashcardModels.count {
                        index += 1
                    }
                    else {
                        print("finished!")
                    }
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
