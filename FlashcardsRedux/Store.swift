//
//  Store.swift
//  FlashcardsRedux
//
//  Created by Yotam Ohayon on 27.10.21.
//

import Foundation

public typealias Reducer<Value, Action> = (inout Value, Action) -> Void /*[Effect<Action>]*/

public final class Store<State, Action>: ObservableObject {
    @Published public var state: State
    private let reducer: (inout State, Action) -> Void /*[Effect]*/
    private let name: String

    public init(name: String, state: State, reducer: @escaping (inout State, Action) -> Void) {
        self.name = name
        self.state = state
        self.reducer = reducer
    }

    public func send(_ action: Action) {
        print(action, "sent to", name, "store", #file, #function)
        reducer(&state, action)
    }

    public func view<LocalState, LocalAction>(
        name: String,
        action actionMapper: @escaping (LocalAction) -> Action,
        state stateMapper: @escaping (State) -> LocalState
    ) -> Store<LocalState, LocalAction> {
        let localStore = Store<LocalState, LocalAction>(
            name: name,
            state: stateMapper(state)
        ) { [weak self, name] localState, localAction in
            guard let self = self else { return }
            print("reducer in ", name, "created by view function")
            let action = actionMapper(localAction)
            self.send(action)
            localState = stateMapper(self.state)
//            self?.reducer(&state, action)
        }

        return localStore
    }
}

public func combine<State, Action>(_ reducers: Reducer<State, Action>...) -> Reducer<State, Action> {
  return { value, action in
//    let effects = reducers.flatMap { $0(&value, action) }
//    return effects
      print("executing", action, "in the combined reducer", #file, #function)
      reducers.forEach { $0(&value, action) }
  }
}

public func pullback<GlobalState, LocalState, GlobalAction, LocalAction>(
    reducer: @escaping Reducer<LocalState, LocalAction>,
    stateKeyPath:  WritableKeyPath<GlobalState, LocalState>,
    actionKeyPath: WritableKeyPath<GlobalAction, LocalAction>
) -> Reducer<GlobalState, GlobalAction> {
    return { globalState, gloablAction in
        let localAction = gloablAction[keyPath: actionKeyPath]
        print(gloablAction, "converted to", localAction, #file, #function)
        reducer(&globalState[keyPath: stateKeyPath], localAction)
    }
}
