//
//  RockTrackListViewModelTests.swift
//  Rock TracksTests
//
//  Created by Yogesh Bharate on 11/05/25.
//

import XCTest
@testable import Rock_Tracks

final class RockTrackListViewModelTests: XCTestCase {
    
    var sut: RockTrackListViewModel!
    var mockService: MockRockTracksService!
    
    override func setUp() {
        super.setUp()
        mockService = MockRockTracksService()
        sut = RockTrackListViewModel(service: mockService)
    }
    
    override func tearDown() {
        mockService = nil
        sut = nil
        super.tearDown()
    }
    
    func test_fetchRockTracks_withSuccess() async {
        XCTAssertFalse(mockService.isFetchRockTracksCalled)
        XCTAssertEqual(sut.state, .idle, "Initial State should be idle")
        await sut.fetchRockTracks()
        XCTAssertTrue(mockService.isFetchRockTracksCalled)
        XCTAssertEqual(sut.rockTracks.count, 10)
        XCTAssertEqual(sut.state, .loaded, "State should be loaded")
    }
    
    func test_fetchRockTracks_withError() async {
        mockService.isFetchRockError = true
        XCTAssertFalse(mockService.isFetchRockTracksCalled)
        XCTAssertEqual(sut.state, .idle, "Initial State should be idle")
        await sut.fetchRockTracks()
        XCTAssertTrue(mockService.isFetchRockTracksCalled)
        XCTAssertTrue(sut.rockTracks.isEmpty)
        XCTAssertEqual(sut.state, .error, "State should be error")
    }

}
