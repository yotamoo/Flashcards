//
//  FlashcardRepository.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import Foundation
import Combine

protocol FlashcardRepositoryType {
    var flashcards: AnyPublisher<[FlashcardModel], Error> { get }
}

class FlashcardRepository: FlashcardRepositoryType {
    var flashcards: AnyPublisher<[FlashcardModel], Error> {
        Just([
            FlashcardModel(id: .init(), front: "asdf", back: "asdf")
        ])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
