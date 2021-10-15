//
//  DeckModel.swift
//  Flashcards
//
//  Created by Justyna Kleczar on 15/10/2021.
//

import Foundation

struct DeckModel: Identifiable, Codable, Equatable {
    let id: UUID
    let title: String
    let flashcards: [FlashcardModel]
}
