//
//  DeckRepository.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import Foundation
import Combine

public struct DeckRepositoryEnvironment {
    let decks: AnyPublisher<[DeckModel], Error>
    let userDefaults: UserDefaults
}

extension DeckRepositoryEnvironment {
    public static var live: Self {
        .init(decks: DeckService().getFlashcardDecks(),
              userDefaults: .standard)
    }
}

private let key = "flashcards"

public struct DeckRepository {
    public let decks: AnyPublisher<[DeckModel], Error>
    
    public init(environment: DeckRepositoryEnvironment = .live) {
        decks = environment.decks.handleEvents(receiveOutput: {
            environment.userDefaults.saveValue($0, forKey: key)
        }).eraseToAnyPublisher()
    }
}

extension UserDefaults {
    func saveValue<Value: Encodable>(_ value: Value, forKey key: String) {
        guard let data = try? JSONEncoder().encode(value) else {
            fatalError("could not encode \(String(describing: Value.self))")
        }

        set(data, forKey: key)
    }

    func loadValue<Value: Decodable>(forKey key: String) -> Value? {
        guard let data = data(forKey: key),
              let parsed = try? JSONDecoder().decode(Value.self, from: data) else {
                  return nil
        }

        return parsed
    }
}
