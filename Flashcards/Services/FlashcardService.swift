//
//  FlashcardService.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import Foundation
import Combine

protocol FlashcardServiceProtocol {
    
    func getFlashcards(completion: @escaping (Result<[FlashcardModel], Error>) -> Void)
}

class FlashcardService: FlashcardServiceProtocol {
    
    func getFlashcards(completion: @escaping (Result<[FlashcardModel], Error>) -> Void) {
        
        completion(.success([FlashcardModel(front: "der Hund", back: "dog"),
                             FlashcardModel(front: "die Katze", back: "cat"),
                             FlashcardModel(front: "die Maus", back: "mouse")]))
    }
}
