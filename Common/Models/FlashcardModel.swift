//
//  FlashcardModel.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import Foundation

public struct FlashcardModel: Equatable, Identifiable, Codable {
    public let id: UUID
    public let front: String
    public let back: String

    public init(id: UUID = .init(), front: String, back: String) {
        self.id = id
        self.front = front
        self.back = back
    }
}
