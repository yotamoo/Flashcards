//
//  FlashcardRepository.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import Foundation
import Combine

protocol FlashcardRepositoryType {
    
    func getFlashcards() -> AnyPublisher<[FlashcardModel], Error>
}

struct FlashcardRepository: FlashcardRepositoryType {
    
    private let service: FlashcardServiceProtocol
    
    private var userDefaults: UserDefaults
    
    init() {
        self.service = FlashcardService()
        self.userDefaults = UserDefaults.standard
    }
    
    private func saveToUserDefaults(_ flashcards: [FlashcardModel]) {
        for flashcard in flashcards {
            userDefaults.set(flashcard.back, forKey: flashcard.front)
        }
    }
    
    private func fetchFromUserDefaults() -> [FlashcardModel] {
        
        var results: [FlashcardModel] = []
        let allValues = userDefaults.dictionaryRepresentation()
        
        for flashcard in allValues {
            guard let back = flashcard.value as? String else { return [] }
            results.append(FlashcardModel(front: flashcard.key, back: back))
        }
            
        return results
    }
    
    func getFlashcards() -> AnyPublisher<[FlashcardModel], Error> {
        service.getFlashcards { [weak self] result in
            switch result {
            case .success(let flashcards):
                return Just(flashcards)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            case .failure:
                let flashcardModels = fetchFromUserDefaults()
                return Just(flashcards)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
        }
    }
}
