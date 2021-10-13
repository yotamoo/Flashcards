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

class DeckViewViewModelTests: QuickSpec {
    override func spec() {
        var sut: DeckViewViewModel!

        beforeEach {
            sut = DeckViewViewModel(flashcardModels: Constants.flashcards)
        }

        describe("flashcardModel") {
            it("passes the values as is from the repository") {
                expect(sut.flashcardModel) == Constants.flashcards.first
            }
        }
    }
}
