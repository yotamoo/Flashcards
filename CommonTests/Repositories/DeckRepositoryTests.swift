//
//  DeckRepositoryTests.swift
//  CommonTests
//
//  Created by Yotam Ohayon on 27.10.21.
//

import Quick
import Nimble
import Combine
@testable import Common

class DeckRepositoryTests: QuickSpec {
    override func spec() {
        var deckModelSubject: PassthroughSubject<[DeckModel], Error>!
        var sut: DeckRepository!
        var completion: Subscribers.Completion<Error>!
        var cancellable: AnyCancellable?
        var output: [DeckModel]!

        beforeEach {
            deckModelSubject = PassthroughSubject<[DeckModel], Error>()
            sut = DeckRepository(environment: .init(
                decks: deckModelSubject.eraseToAnyPublisher(),
                userDefaults: .standard
            ))

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

        describe("flashcardModel") {
            var expected: [DeckModel]!

            beforeEach {
                expected = [.init(id: .init(), title: "title", flashcards: [
                    .init(id: .init(), front: "1", back: "1")
                ])]
                deckModelSubject.send(expected)
            }

            it("passes the values as is from the repository") {
                expect(output).toEventually(equal(expected))
            }
        }
    }
}
