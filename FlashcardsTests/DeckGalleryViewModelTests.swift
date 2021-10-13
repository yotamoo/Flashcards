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
@testable import Flashcards

class DeckGalleryViewModelTests: QuickSpec {
    override func spec() {
        var sut: DeckGalleryViewModel!

        beforeEach {
            sut = DeckGalleryViewModel()
        }

        describe("flashcardModel") {
            it("passes the values as is from the repository") {
//                expect(sut.flashcardModel) == DeckModelEnvironment.debug.decks.first
            }
        }
    }
}
