//
//  FlashcardService.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import Foundation
import Combine

protocol FlashcardServiceProtocol {
    
    func getFlashcards() -> AnyPublisher<[DeckModel], Error>
}

class FlashcardService: FlashcardServiceProtocol {
    
    func getFlashcards() -> AnyPublisher<[DeckModel], Error> {
        var flashcards: AnyPublisher<[DeckModel], Error> {
            Just<[DeckModel]>(
                Constants.decks
            )
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return flashcards
    }
}
