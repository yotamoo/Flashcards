//
//  DeckView.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import SwiftUI
import Combine
import Common

public struct DeckView: View {
    @ObservedObject var viewModel: DeckViewState
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    public init(viewModel: DeckViewState) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
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
