//
//  ContentViewRedux.swift
//  FlashcardsRedux
//
//  Created by Yotam Ohayon on 19.10.21.
//

import SwiftUI
import UI
import Common

enum AppAction {
    case someAction
}

struct AppState {
    var decks: [DeckModel] = []
}

let appReducer: Reducer<AppState, AppAction> = { state, action in
    switch action {
    case .someAction:
        print("tapped")
    }
}

//let appReducer: Reducer<AppState, AppAction> = Architecture.combine(
//    pullback(reducer: exampleViewReducer,
//             stateKeyPath: \.asExampleViewState,
//             actionKeyPath: \.asExampleViewAction)
//)

struct ContentViewRedux: View {
    @ObservedObject private var store = Store<AppState, AppAction>(
        name: "ContentViewRedux",
        state: .init(decks: Mocks.decks),
        reducer: appReducer
    )

    var body: some View {
        NavigationView {
            List {
                ForEach(store.state.decks) { deck in
                    NavigationLink(deck.title) {
                        DeckView(viewModel: .init(title: deck.title, flashcardModels: deck.flashcards))
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewRedux()
    }
}
