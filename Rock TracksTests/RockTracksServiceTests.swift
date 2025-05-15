//
//  RockTracksServiceTests.swift
//  Rock TracksTests
//
//  Created by Yogesh Bharate on 15/05/25.
//

import XCTest
@testable import Rock_Tracks

final class RockTracksServiceTests: XCTestCase {
    
    var sut: RockTracksService!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        sut = RockTracksService(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        mockNetworkManager = nil
        sut = nil
        super.tearDown()
    }
    
    func test_fetchRockTracks_withSuccess() async {
        let expectedResponse = AppHelper.load(filename: "RockTrackResponse")
        mockNetworkManager.mockResponse = expectedResponse
        do {
            let response = try await sut.fetchRockTracks(from: "Test")
            XCTAssertEqual(response.count, 10)
            XCTAssertEqual(response.first?.trackId, 169003415)
            XCTAssertEqual(response.first?.artistName, "Journey")
            XCTAssertEqual(response.first?.trackPrice, 1.29)
            XCTAssertEqual(response.first?.trackTimeMillis, 250835)
            XCTAssertEqual(response.first?.releaseDate, "1981-06-03T07:00:00Z")
        } catch {
            XCTFail("Service should not failed")
        }
    }
    
    func test_fetchRockTracks_withError() async {
        mockNetworkManager.isNetworkError = true
        do {
            let response = try await sut.fetchRockTracks(from: "Test")
            XCTFail("\(response) should be nil")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
