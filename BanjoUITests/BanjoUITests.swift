//
//  BanjoUITests.swift
//  BanjoUITests
//
//  Created by Jarrod Parkes on 2/12/17.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import XCTest

class BanjoUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTakeScreens() {
        let app = XCUIApplication()
        sleep(4)
        snapshot("StartScreen")
        app.buttons["searchButton"].tap()
        snapshot("SearchScreen")
    }
}
