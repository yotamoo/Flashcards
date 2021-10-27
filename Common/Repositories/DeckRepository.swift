//
//  DeckRepository.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import Foundation
import Combine

public protocol DeckRepositoryType {
    func getFlashcardDecks() -> AnyPublisher<[DeckModel], Error>
}

public struct DeckRepository: DeckRepositoryType {
    private let service: DeckServiceProtocol
    private var userDefaults: UserDefaults
    private let key = "flashcards"
    
    public init(deckService: DeckServiceProtocol = DeckService(),
                userDefaults: UserDefaults = .standard) {
        self.service = deckService
        self.userDefaults = userDefaults
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
