//
//  DummyModelRepositoryTests.swift
//  CommonTests
//
//  Created by Yotam Ohayon on 18.10.21.
//

import Foundation
import Quick
import Nimble
import Combine
@testable import Common

class DummyModelRepositoryTests: QuickSpec {
    override func spec() {
        var subject: PassthroughSubject<[DummyModel], Never>!
        var apiCall: ApiCall!
        var sut: DummyModelRepository!

        beforeEach {
            subject = .init()
            apiCall = .init(result: subject.eraseToAnyPublisher())
            sut = .init(apiCall: apiCall)
        }

        describe("models") {
            var cancellable: AnyCancellable?
            var result: [DummyModel]!

            beforeEach {
                cancellable = sut.models.sink { result = $0 }
            }

            it("passes the values as is from the repository") {
                expect(result).to(beNil())
            }

            it("silences the warning") {
                expect(cancellable).toNot(beNil())
            }

            context("when there are models") {
                var model: DummyModel!
                beforeEach {
                    model = .init()
                    subject.send([model])
                }

                it("passes the values as is from the repository") {
                    expect(result) == [model]
                }
            }
        }
    }
}

