//
//  RockTrackDetailViewModelTests.swift
//  Rock TracksTests
//
//  Created by Yogesh Bharate on 15/05/25.
//

import XCTest
@testable import Rock_Tracks

final class RockTrackDetailViewModelTests: XCTestCase {
    var sut: RockTrackDetailViewModel!
    
    override func setUp() {
        super.setUp()
        sut = RockTrackDetailViewModel(track: .arrange.first!)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_getTrackDuration_returnExpectedValue() {
        XCTAssertEqual(sut.getTrackDuration(trackTimeMillis: 0), "00:00")
        XCTAssertEqual(sut.getTrackDuration(trackTimeMillis: sut.track.trackTimeMillis), "04:10")
    }
    
    func test_formatDate_returnExpectedValue() {
        XCTAssertEqual(sut.formatDate("2021-05-15T12:00:00Z"), "15 May 2021")
        XCTAssertEqual(sut.formatDate(sut.track.releaseDate), "03 June 1981")
    }
}
