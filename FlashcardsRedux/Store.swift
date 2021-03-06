//
//  Store.swift
//  FlashcardsRedux
//
//  Created by Yotam Ohayon on 27.10.21.
//

import Combine

public typealias Effect<Output> = AnyPublisher<Output, Never>
public typealias Reducer<Value, Action> = (inout Value, Action) -> [Effect<Action>]

enum NeverAction {
    var asAppAction: AppAction? { nil }
}

func neverReduer<State>() -> Reducer<State, NeverAction> {
    return { _, _  in [] }
}

public final class Store<State, Action>: ObservableObject {
    @Published public var state: State
    private let reducer: Reducer<State, Action>
    private let name: String
    private var cancellables = Set<AnyCancellable>()

    public init(name: String, state: State, reducer: @escaping Reducer<State, Action>) {
        self.name = name
        self.state = state
        self.reducer = reducer
    }

    public func send(_ action: Action) {
        print(action, "sent to", name, "store", #file, #function)
        let effects = reducer(&state, action)
        effects.forEach { [weak self] effect in
            guard let self = self else { return }
            var didComplete = false
            var effectCancelabble: AnyCancellable?
            effectCancelabble = effect.sink(
                receiveCompletion: { _ in
                    didComplete = true
                    if let effectCancelabble = effectCancelabble {
                        self.cancellables.remove(effectCancelabble)
                    }
                },
                receiveValue: self.send
            )

            if !didComplete, let effectCancelabble = effectCancelabble {
                self.cancellables.insert(effectCancelabble)
            }
        }
    }

    public func view<LocalState, LocalAction>(
        name: String,
        action actionMapper: KeyPath<LocalAction, Action?>,
        state stateMapper: KeyPath<State, LocalState>
    ) -> Store<LocalState, LocalAction> {
        let localStore = Store<LocalState, LocalAction>(
            name: name,
            state: state[keyPath: stateMapper]
        ) { [weak self, name] localState, localAction in
            guard let self = self,
                  let globalAction = localAction[keyPath: actionMapper] else { return [] }
            print("reducer in ", name, "created by view function")
            self.send(globalAction)
            localState = self.state[keyPath: stateMapper]
            return []
        }

        return localStore
    }
}

public func combine<State, Action>(_ reducers: Reducer<State, Action>...) -> Reducer<State, Action> {
  return { value, action in
      print("executing", action, "in the combined reducer", #file, #function)
      let effects = reducers.map { $0(&value, action) }.reduce([], +)
      return effects
  }
}

public func pullback<GlobalState, LocalState, GlobalAction, LocalAction>(
    reducer: @escaping Reducer<LocalState, LocalAction>,
    stateKeyPath:  WritableKeyPath<GlobalState, LocalState>,
    actionKeyPath: WritableKeyPath<GlobalAction, LocalAction?>
) -> Reducer<GlobalState, GlobalAction> {
    return { globalState, gloablAction in
        guard let localAction = gloablAction[keyPath: actionKeyPath] else {
            return []
        }
        print(gloablAction, "converted to", localAction, #file, #function)
        let localEffects = reducer(&globalState[keyPath: stateKeyPath], localAction)

        return localEffects.map { localEffect -> Effect<GlobalAction> in
            return localEffect.map { localAction in
                var globalAction = gloablAction
                globalAction[keyPath: actionKeyPath] = localAction
                return globalAction
            }.eraseToAnyPublisher()
        }
    }
}
