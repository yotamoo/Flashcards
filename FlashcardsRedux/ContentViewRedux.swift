//
//  ContentViewRedux.swift
//  FlashcardsRedux
//
//  Created by Yotam Ohayon on 19.10.21.
//

import SwiftUI
import UI

enum AppAction {
    case someAction
}

struct AppState {
    let name = "yotam"
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
        state: .init(),
        reducer: appReducer
    )

    var body: some View {
        Button("Click") {
            store.send(.someAction)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewRedux()
    }
}
