//
//  RockTrackDetailViewUITests.swift
//  Rock TracksTests
//
//  Created by Yogesh Bharate on 16/05/25.
//

import XCTest
@testable import Rock_Tracks

final class RockTrackDetailViewUITests: BaseUITests {
    
    func test_rockTrackDetailView_loadsAsExpected() {
        goToRockTrackDetailsView()
        
        XCTAssertTrue(app.buttons["chevron.backward"].exists)
        
        XCTAssertEqual(app.staticTexts["trackDetailView.169003415.trackName"].label,
                       "Don't Stop Believin' (2024 Remaster)")
        XCTAssertEqual(app.staticTexts["trackDetailView.169003415.artistName"].label, "Journey")
        XCTAssertEqual(app.staticTexts["trackDetailView.169003415.trackPrice"].label, "1.29")
        XCTAssertEqual(app.staticTexts["trackDetailView.169003415.trackDuration"].label, "04:10")
        XCTAssertEqual(app.staticTexts["trackDetailView.169003415.releaseDate"].label, "03 June 1981")
        
        XCTAssertEqual(app.buttons["trackDetailView.moreDetails.button"].label, "More details")
    }
    
    func test_rockTrackDetailView_moreDetails_openAsExpected() {
        goToRockTrackDetailsView()
        XCTAssertEqual(app.buttons["trackDetailView.moreDetails.button"].label, "More details")
        app.buttons["trackDetailView.moreDetails.button"].tap()
        
        let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
        guard safari.wait(for: .runningForeground, timeout: 5) else {
            XCTFail("Unable be to launch Safari")
            return
        }
        safari.textFields["Address"].tap()
        let enteredURL = safari.textFields["Address"].value as? String ?? ""
        XCTAssertTrue(enteredURL.contains("https://music.apple.com/us/album/dont-stop-believin-2024-remaster"))
    }
}

// MARK: - Helper functions
extension RockTrackDetailViewUITests {
    private func goToRockTrackDetailsView() {
        XCTAssertTrue(app.staticTexts["Rock Tracks"].waitForExistence(timeout: 1))
        
        XCTAssertEqual(app.staticTexts["trackListView.169003415.trackName"].label,
                       "Don't Stop Believin' (2024 Remaster)")
        app.staticTexts["trackListView.169003415.trackName"].tap()
    }
}
