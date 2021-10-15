//
//  FlashcardService.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import Foundation
import Firebase
import Combine

protocol FlashcardServiceProtocol {
    
    func getFlashcardDecks() -> AnyPublisher<[DeckModel], Error>
}

class FlashcardService: FlashcardServiceProtocol {
    
    func getFlashcardDecks() -> AnyPublisher<[DeckModel], Error> {
        
        let db = Firestore.firestore()
        
        return Future<[DeckModel], Error> { promise in
            
            db.collection("decks").getDocuments() { (result, error) in
                
                if let error = error {
                    promise(.failure(error))
                } else if let result = result {

                    var decks: [DeckModel] = []
                    
                    for deck in result.documents {
                        let data = deck.data()
                        
                        guard let title = data["title"] as? String,
                              let flashcards = data["flashcards"] as? [Dictionary<String, String>] else {
                                  return
                              }
                                                
                        var flashcardModels: [FlashcardModel] = []
                        for flashcard in flashcards {
                            
                            if let front = flashcard["front"], let back = flashcard["back"] {
                                flashcardModels.append(FlashcardModel(id: UUID(),
                                                                      front: front,
                                                                      back: back))
                            }
                        }
                        
                        let deck = DeckModel(id: UUID(), title: title, flashcards: flashcardModels)
                        decks.append(deck)
                    }

                    promise(.success(decks))
                }
            }
        }.eraseToAnyPublisher()
    }
}
