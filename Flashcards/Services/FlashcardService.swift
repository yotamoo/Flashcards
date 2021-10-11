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
    
    func getFlashcards() -> AnyPublisher<[FlashcardModel], Error>
}

class FlashcardService: FlashcardServiceProtocol {
    
    func getFlashcards() -> AnyPublisher<[FlashcardModel], Error> {
        
        let db = Firestore.firestore()
        
        return Future<[FlashcardModel], Error> { promise in
            
            db.collection("flashcards").getDocuments() { (result, error) in
                
                if let error = error {
                    promise(.failure(error))
                } else if let result = result {
                    var flashcards: [FlashcardModel] = []
                    for flashcard in result.documents {
                        let id = UUID()
                        let data = flashcard.data()
                        flashcards.append(FlashcardModel(id: id, front: data["front"] as! String,
                                                         back: data["back"] as! String))
                    }
                    promise(.success(flashcards))
                }
            }
        }.eraseToAnyPublisher()
    }
}
