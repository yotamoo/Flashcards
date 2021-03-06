//
//  DeckViewStateTests.swift
//  FlashcardsTests
//
//  Created by Yotam Ohayon on 06.10.21.
//

import Foundation
import Quick
import Nimble
import Combine
import Common
@testable import UI

class DeckViewStateTests: QuickSpec {
    override func spec() {
        var sut: DeckViewState!

        beforeEach {
            sut = DeckViewState(title: "title", flashcardModels: Mocks.flashcards)
        }

        describe("flashcardModel") {
            it("passes the values as is from the repository") {
                expect(sut.flashcardModel) == Mocks.flashcards.first
            }
        }
    }
}
