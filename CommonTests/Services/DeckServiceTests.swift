//
//  DeckServiceTests.swift
//  CommonTests
//
//  Created by Yotam Ohayon on 27.10.21.
//

import Quick
import Nimble
import Combine
@testable import Common

class DeckServiceTests: QuickSpec {
    override func spec() {
        var sut: DeckService!
        var completion: Subscribers.Completion<Error>!
        var cancellable: AnyCancellable?
        var deckName: String!
        var completionBlock: (([DeckModel]?, Error?) -> Void)!
        var output: [DeckModel]!

        beforeEach {
            sut = DeckService(environment: .init(fetch: { actualDeckName, actualCompletion in
                deckName = actualDeckName
                completionBlock = actualCompletion
            }))

            cancellable = sut.decks.sink(receiveCompletion: {
                completion = $0
            }, receiveValue: {
                output = $0
            })
        }

        it("does not have an initial value") {
            expect(output).to(beNil())
        }

        it("does complete upon start") {
            expect(completion).to(beNil())
        }

        it("silence warning") {
            expect(cancellable).toNot(beNil())
        }

        it("fetches the right collection") {
            expect(deckName).to(equal("decks"))
        }

        describe("flashcardModel") {
            var expected: [DeckModel]!

            beforeEach {
                expected = [.init(id: .init(), title: "title", flashcards: [
                    .init(id: .init(), front: "1", back: "1")
                ])]
                completionBlock(expected, nil)
            }

            it("passes the values as is from the repository") {
                expect(output).toEventually(equal(expected))
            }
        }
    }
}

