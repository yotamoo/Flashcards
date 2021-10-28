//
//  User.swift
//  Common
//
//  Created by Yotam Ohayon on 28.10.21.
//

import Foundation

public struct User: Identifiable, Codable {
    public let id: UUID
    public let name: String

    public init(id: UUID = .init(), name: String) {
        self.id = id
        self.name = name
    }
}
