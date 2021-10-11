//
//  DeckViewViewModelTests.swift
//  FlashcardsTests
//
//  Created by Yotam Ohayon on 06.10.21.
//

import Foundation
import Quick
import Nimble
import Combine
@testable import Flashcards

struct FlashcardRepositoryMock: FlashcardRepositoryType {
    let flashcardsSubject = PassthroughSubject<[FlashcardModel], Error>()
    func getFlashcards() -> AnyPublisher<[FlashcardModel], Error> {
        flashcardsSubject.eraseToAnyPublisher()
    }
}

class DeckViewViewModelTests: QuickSpec {
    override func spec() {
        var mockFlashcardRepository: FlashcardRepositoryMock!
        var sut: DeckViewViewModel!
        
        beforeEach {
            mockFlashcardRepository = FlashcardRepositoryMock()
            sut = DeckViewViewModel(flashcardRepository: mockFlashcardRepository)
        }
        
        describe("flashcardModel") {
            it("passes the values as is from the repository") {
                let flashcardModel = FlashcardModel(id: .init(), front: "front", back: "back")
                mockFlashcardRepository.flashcardsSubject.send([flashcardModel])
                expect(sut.flashcardModel) == flashcardModel
            }
        }
    }
}
