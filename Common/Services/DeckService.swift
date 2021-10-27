//
//  DeckService.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import Foundation
import Firebase
import Combine

public struct DeckService {
    public init() {}

    public func getFlashcardDecks() -> AnyPublisher<[DeckModel], Error> {
        let db = Firestore.firestore()

        return db.collection("decks").documentsPublisher
            .map { documents in documents?.compactMap { $0.data() } ?? [] }
            .map { $0.compactMap(\.asDeckModel) }
            .eraseToAnyPublisher()
    }
}

private extension Firebase.CollectionReference {
    var documentsPublisher: AnyPublisher<[QueryDocumentSnapshot]?, Error> {
        Future<[QueryDocumentSnapshot]?, Error> { [weak self] promise in
            self!.getDocuments { querySnapshot, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(querySnapshot?.documents))
                }
            }
        }.eraseToAnyPublisher()
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
