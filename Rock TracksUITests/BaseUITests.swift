//
//  BaseUITests.swift
//  Rock TracksTests
//
//  Created by Yogesh Bharate on 16/05/25.
//

import XCTest
@testable import Rock_Tracks

class BaseUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launchArguments.append("--ui-testing")
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
}
