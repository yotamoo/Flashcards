//
//  LoginView.swift
//  FlashcardsRedux
//
//  Created by Yotam Ohayon on 28.10.21.
//

import Common
import SwiftUI

extension AppState {
    var asLoginViewState: LoginViewState {
        get { .init(user: user) }
        set { self.user = newValue.user }
    }
}

extension AppAction {
    var asLoginViewAction: LoginViewAction? {
        get {
            switch self {
            case let .userDidLogIn(user):
                return .userDidLogIn(user)
            }
        }
        set {
            switch newValue {
            case let .userDidLogIn(user):
                self = .userDidLogIn(user)
            case .none:
                return
            }
        }
    }
}

struct LoginViewState {
    var user: User?
}

enum LoginViewAction {
    case userDidLogIn(User)

    var asAppAction: AppAction? {
        switch self {
        case .userDidLogIn(let user):
            return .userDidLogIn(user)
        }
    }
}

let loginViewReducer: Reducer<LoginViewState, LoginViewAction> = { state, action in
    switch action {
    case let .userDidLogIn(user):
        state.user = user
    }
}

struct LoginView: View {
    @ObservedObject private var store: Store<LoginViewState, LoginViewAction>

    init(store: Store<LoginViewState, LoginViewAction>) {
        self.store = store
    }

    var body: some View {
        Button("Login") {
            store.send(.userDidLogIn(.init(name: "Yotam")))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(store: .init(
            name: "LoginView",
            state: .init(),
            reducer: loginViewReducer
        ))
    }
}
