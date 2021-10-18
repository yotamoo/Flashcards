//
//  DummyModelRepository.swift
//  Common
//
//  Created by Yotam Ohayon on 18.10.21.
//

import Foundation
import Combine

public struct ApiCall {
    let result: AnyPublisher<[DummyModel], Never>

    init() {
        self.result = Just([.init()]).eraseToAnyPublisher()
    }

    init(result: AnyPublisher<[DummyModel], Never>) {
        self.result = result
    }
}

public struct DummyModelRepository {
    public let models: AnyPublisher<[DummyModel], Never>

    init(apiCall: ApiCall = .init()) {
        self.models = apiCall.result.eraseToAnyPublisher()
    }
}

public extension DummyModelRepository {
    static var production: Self {
        .init()
    }

    static var development: Self {
        .init(apiCall: .init(result: Just([]).eraseToAnyPublisher()))
    }
}
