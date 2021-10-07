//
//  FlashcardService.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import Foundation
import Combine

protocol FlashcardServiceProtocol {
    
    func getFlashcards() -> AnyPublisher<[FlashcardModel], Error>
}

class FlashcardService: FlashcardServiceProtocol {
    
    func getFlashcards() -> AnyPublisher<[FlashcardModel], Error> {
        var flashcards: AnyPublisher<[FlashcardModel], Error> {
            Just<[FlashcardModel]>(
                [FlashcardModel(id: .init(), front: "der Hund", back: "dog"),
                 FlashcardModel(id: .init(), front: "die Katze", back: "cat"),
                 FlashcardModel(id: .init(), front: "die Maus", back: "mouse")]
            )
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return flashcards
    }
}
