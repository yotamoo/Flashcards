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
    case userDidLogIn(User)
}

struct AppState {
    var user: User?
    var decks: [DeckModel]?
}

let appReducer: Reducer<AppState, AppAction> = combine(
    pullback(reducer: loginViewReducer,
             stateKeyPath: \.asLoginViewState,
             actionKeyPath: \.asLoginViewAction)
)

struct ContentViewRedux: View {
    @ObservedObject private var store = Store<AppState, AppAction>(
        name: "ContentViewRedux",
        state: .init(decks: Mocks.decks),
        reducer: appReducer
    )

    var body: some View {
        if let user = store.state.user {
            if let decks = store.state.decks {
                NavigationView {
                    List {
                        ForEach(decks) { deck in
                            NavigationLink(deck.title) {
                                DeckView(viewModel: .init(title: deck.title, flashcardModels: deck.flashcards))
                            }
                        }
                    }
                }
            } else {
                // create a deck
                EmptyView()
            }
        } else {
            LoginView(store: store.view(
                name: "LoginView",
                action: { $0.asAppAction },
                state: { _ in .init() }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewRedux()
    }
}
