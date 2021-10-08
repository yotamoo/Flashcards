//
//  FlashcardModel.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import Foundation

struct FlashcardModel: Equatable, Identifiable, Codable {
    let id: UUID
    let front: String
    let back: String
}
