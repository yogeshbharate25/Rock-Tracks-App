//
//  Rock_TracksUITests.swift
//  Rock TracksUITests
//
//  Created by Yogesh Bharate on 11/05/25.
//

import XCTest
@testable import Rock_Tracks

final class RockTrackListViewUITests: BaseUITests {
    
    func test_rockTrackListView_loadsAsExpected() {
        XCTAssertTrue(app.staticTexts["Rock Tracks"].waitForExistence(timeout: 1))
        // Check Track 1
        XCTAssertEqual(app.staticTexts["trackListView.169003415.trackName"].label,
                       "Don't Stop Believin' (2024 Remaster)")
        XCTAssertEqual(app.staticTexts["trackListView.169003415.artistName"].label, "Journey")
        XCTAssertEqual(app.staticTexts["trackListView.169003415.trackPrice"].label, "1.29")
        // Check Track 2
        XCTAssertEqual(app.staticTexts["trackListView.214403648.trackName"].label, "Rockstar")
        XCTAssertEqual(app.staticTexts["trackListView.214403648.artistName"].label, "Nickelback")
        XCTAssertEqual(app.staticTexts["trackListView.214403648.trackPrice"].label, "1.29")
        // Check Track 3
        XCTAssertEqual(app.staticTexts["trackListView.277635828.trackName"].label, "I'm Yours")
        XCTAssertEqual(app.staticTexts["trackListView.277635828.artistName"].label, "Jason Mraz")
        XCTAssertEqual(app.staticTexts["trackListView.277635828.trackPrice"].label, "1.29")
    }
}
