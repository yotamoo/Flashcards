//
//  DeckModel.swift
//  Flashcards
//
//  Created by Justyna Kleczar on 15/10/2021.
//

import Foundation

public struct DeckModel: Identifiable, Codable, Equatable {
    public let id: UUID
    public let title: String
    public let flashcards: [FlashcardModel]

    public init(id: UUID = .init(), title: String, flashcards: [FlashcardModel]) {
        self.id = id
        self.title = title
        self.flashcards = flashcards
    }
}
