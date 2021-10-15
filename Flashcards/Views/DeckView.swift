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
    @Published var showAlert = false
    let title: String
    
    private let flashcardModels: [FlashcardModel]
    private var index: Int = 0 {
        didSet {
            progress = Double(index) / Double(flashcardModels.count) * 100
        }
    }
    
    init(title: String, flashcardModels: [FlashcardModel]) {
        self.title = title
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
    
    func backButtonPressed() {
        showAlert = true
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
                        FlashcardView(
                            model: flashcardModel,
                            completion: viewModel.cardViewed
                        ).id(flashcardModel.id)
                        
                        ProgressBarView(progress: viewModel.progress)
                            .frame(width: 400, height: 30)
                    }
                    else {
                        fatalError("no card to show")
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            viewModel.backButtonPressed()
        }){
            Image(systemName: "arrow.left")
        })
        .navigationTitle(viewModel.title)
        .actionSheet(isPresented: $viewModel.showAlert) {
            ActionSheet(
                title: Text("Actions"),
                message: Text("Available actions"),
                buttons: [
                    .cancel { print("cancelled") },
                    .default(Text("Regret")),
                    .destructive(Text("Confirm"), action: {
                        self.mode.wrappedValue.dismiss()
                    })
                ]
            )
        }
    }
}

struct DeckView_Previews: PreviewProvider {
    static var previews: some View {
        DeckView(
            viewModel: .init(
                title: "example",
                flashcardModels: [.init(id: .init(),
                                        front: "der Hund",
                                        back: "dog")]
            )
        )
    }
}
