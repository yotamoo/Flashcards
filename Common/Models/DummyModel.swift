//
//  DummyModel.swift
//  Common
//
//  Created by Yotam Ohayon on 18.10.21.
//

import Foundation

public struct DummyModel: Identifiable, Equatable {
    public let id: UUID
    public var title: String
    public var done: Bool

    public init(id: UUID = .init(),
                title: String = "",
                done: Bool = false) {
        self.id = id
        self.title = title
        self.done = done
    }
}
