//
//  APIServiceTests.swift
//  SatelliteTests
//
//  Created by Andrew Roan on 1/27/21.
//

import XCTest
import Combine
@testable import Satellite

class APIServiceTests: XCTestCase {

    let mainQueue = DispatchQueue.main
    let userInitQueue = DispatchQueue.global(qos: .userInitiated)

    func testFetchSatellitesSuccess() {
        let service = APIService()
        let expReceive = expectation(description: "Receive expected, valid, data.")
        let expFinish = expectation(description: "Successfully fetch and decode data.")
        let expectedPage = 1
        let expectedCount = 20
        _ = service.fetchSatellites(page: expectedPage, pageSize: expectedCount)
            .subscribe(on: userInitQueue)
            .receive(on: mainQueue)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        XCTFail("Not expecting a failure - \(String(describing: error))")
                    default:
                        expFinish.fulfill()
                    }
                },
                receiveValue: { value in
                    assert(value.member.count == expectedCount, "Count of satellites should match expectation.")
                    expReceive.fulfill()
                }
            )
        wait(for: [expReceive, expFinish], timeout: 5, enforceOrder: true)
    }

    // TODO: Test edge cases
}
