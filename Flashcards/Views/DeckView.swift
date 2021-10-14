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
    @Published var flashcardModel: FlashcardModel?
    @Published var didFinish = false
    
    private let flashcardModels: [FlashcardModel]
    private var index: Int = 0 {
        didSet {
            progress = Double(index) / Double(flashcardModels.count) * 100
        }
    }
    
    init(flashcardModels: [FlashcardModel]) {
        self.flashcardModels = flashcardModels
        self.flashcardModel = flashcardModels.first
    }
    
    func cardViewed(_ success: Bool, model: FlashcardModel) {
        print(success ? "well done" : "next time")
        index += 1
        if index < flashcardModels.count {
            flashcardModel = flashcardModels[index]
        }
        else {
            print("finished")
            didFinish = true
        }
    }
}

struct DeckView: View {
    @ObservedObject var viewModel: DeckViewViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            if viewModel.didFinish {
                Button("Well Done") {
                    self.mode.wrappedValue.dismiss()
                }
            } else {
                VStack {
                    if let flashcardModel = viewModel.flashcardModel {
                        FlashcardView(model: flashcardModel) {
                            viewModel.cardViewed($0, model: $1)
                        }.id(flashcardModel.id)
                        
                        ProgressBarView(progress: viewModel.progress)
                            .frame(width: 400, height: 30)
                    }
                    else {
                        // later well done view
                        EmptyView()
                    }
                }
            }
        }
    }
}

struct DeckView_Previews: PreviewProvider {
    static var previews: some View {
        DeckView(
            viewModel: .init(
                flashcardModels: [.init(id: .init(),
                                        front: "der Hund",
                                        back: "dog")]
            )
        )
    }
}
