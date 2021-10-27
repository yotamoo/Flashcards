//
//  DeckService.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import Foundation
import Firebase
import Combine

public struct DeckModelEnvironment {
    let fetch: (String, @escaping ([DeckModel]?, Error?) -> Void) -> Void
}

public extension DeckModelEnvironment {
    static var live: Self {
        .init { collectionName, completion in
            Firestore.firestore().collection(collectionName).getDocuments { querySnapshot, error in
                if let error = error {
                    completion(nil, error)
                    return
                }

                guard let documents = querySnapshot?.documents  else {
                    completion(nil, DeckServiceError.general)
                    fatalError()
                }

                completion(documents.asDeckModels, nil)
            }
        }
    }
}

public struct DeckService {
    let decks: AnyPublisher<[DeckModel], Error>

    public init(environment: DeckModelEnvironment = .live) {
        decks = environment.publisher(forKey: "decks")
    }
}

enum DeckServiceError: Error {
    case general
}

extension DeckModelEnvironment {
    func publisher(forKey key: String) -> AnyPublisher<[DeckModel], Error> {
        Future<[DeckModel], Error> { promise in
            self.fetch(key) { deckModels, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }

                guard let deckModels = deckModels else {
                    promise(.failure(DeckServiceError.general))
                    return
                }

                promise(.success(deckModels))
            }
        }.eraseToAnyPublisher()
    }
}

private extension Array where Element == QueryDocumentSnapshot {
    var asDeckModels: [DeckModel] {
        compactMap { $0.data().asDeckModel }
    }
}

private extension Dictionary where Key == String, Value == Any {
    var asDeckModel: DeckModel? {
        guard let title = self["title"] as? String,
              let flashcardsArray = self["flashcards"] as? [[String: String]] else {
                  return nil
              }

        let flashcards = flashcardsArray.compactMap(\.asFlashCard)

        return .init(title: title, flashcards: flashcards)
    }
}

private extension Dictionary where Key == String, Value == String {
    var asFlashCard: FlashcardModel? {
        guard let front = self["front"], let back = self["back"] else {
            return nil
        }

        return .init(front: front, back: back)
    }
}
