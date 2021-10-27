//
//  DeckGalleryViewModelTests.swift
//  FlashcardsTests
//
//  Created by Yotam Ohayon on 13.10.21.
//

import Foundation
import Quick
import Nimble
import Combine
import Common
@testable import UI

class DeckGalleryViewModelTests: QuickSpec {
    
    private var deckRepository = DeckRepositoryMock()
    
    override func spec() {
        var sut: DeckGalleryViewModel!

        beforeEach {
            sut = DeckGalleryViewModel()
        }

        describe("flashcardModel") {
            var expected: [DeckModel]!
            
            beforeEach {
                expected = [.init(id: .init(), title: "title", flashcards: [
                    .init(id: .init(), front: "1", back: "1")
                ])]
                self.deckRepository.flashcardsSubject.send(expected)
            }
            
            it("passes the values as is from the repository") {
                expect(sut.decks) == expected
            }
        }
    }
}
