//
//  FlashcardService.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import Foundation
import Combine

protocol FlashcardServiceType {
    var flashcards: AnyPublisher<[FlashcardModel], Error> { get }
}
