//
//  DummyScreen.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 18.10.21.
//

import SwiftUI
import UI
import Combine
import Common

class DummyScreenViewModel: ObservableObject {
    @Published var models: [DummyModel] = []
    private var cancellable: AnyCancellable?

    init(repo: DummyModelRepository) {
        self.cancellable = repo.models.sink {
            self.models = $0
        }
    }
}

struct DummyScreen: View {
    @ObservedObject private var viewModel: DummyScreenViewModel

    init(viewModel: DummyScreenViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        DummyView(models: $viewModel.models)
    }
}

struct DummyScreen_Previews: PreviewProvider {
    static var previews: some View {
        DummyScreen(
            viewModel: DummyScreenViewModel(
                repo: .production
            )
        )
    }
}
