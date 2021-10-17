//
//  FlashcardRepository.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import Foundation
import Combine

public protocol FlashcardRepositoryType {
    func getFlashcardDecks() -> AnyPublisher<[DeckModel], Error>
}

public struct FlashcardRepository: FlashcardRepositoryType {
    private let service: FlashcardServiceProtocol
    private var userDefaults: UserDefaults
    private let key = "flashcards"
    
    public init() {
        self.service = FlashcardService()
        self.userDefaults = UserDefaults.standard
    }
    
    private func saveToUserDefaults(_ decks: [DeckModel]) {
        guard let data = try? JSONEncoder().encode(decks) else {
            fatalError("could not encode flashcards array")
        }
        
        userDefaults.set(data, forKey: key)
    }
    
    private func fetchFromUserDefaults() -> [DeckModel] {
        guard let data = userDefaults.data(forKey: key),
              let parsed = try? JSONDecoder().decode([DeckModel].self, from: data) else {
                  return []
        }
        
        return parsed
    }
    
    public func getFlashcardDecks() -> AnyPublisher<[DeckModel], Error> {
        service.getFlashcardDecks().handleEvents(receiveOutput: { decks in
            saveToUserDefaults(decks)
        }).eraseToAnyPublisher()
    }
}

struct FlashcardRepositoryMock: FlashcardRepositoryType {
    
    let flashcardsSubject = PassthroughSubject<[DeckModel], Error>()
    
    func getFlashcardDecks() -> AnyPublisher<[DeckModel], Error> {
        flashcardsSubject.eraseToAnyPublisher()
    }
}
