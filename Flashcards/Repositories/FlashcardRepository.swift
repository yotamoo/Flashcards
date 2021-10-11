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
    
    private let key = "flashcards"
    
    init() {
        self.service = FlashcardService()
        self.userDefaults = UserDefaults.standard
    }
    
    private func saveToUserDefaults(_ flashcards: [FlashcardModel]) {
        guard let data = try? JSONEncoder().encode(flashcards) else {
            fatalError("could not encode flashcards array")
        }
        
        userDefaults.set(data, forKey: key)
    }
    
    private func fetchFromUserDefaults() -> [FlashcardModel] {
        guard let data = userDefaults.data(forKey: key),
              let parsed = try? JSONDecoder().decode([FlashcardModel].self, from: data) else {
                  return []
        }
        
        return parsed
    }
    
    func getFlashcards() -> AnyPublisher<[FlashcardModel], Error> {
        
        service.getFlashcards().sink { _ in
            print("done")
        } receiveValue: { in
            saveToUserDefaults($0)
        }
        
//        service.getFlashcards().handleEvents(receiveOutput: { flashcards in
//            saveToUserDefaults(flashcards)
//        }).eraseToAnyPublisher()
    }
}
