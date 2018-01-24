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
        sleep(1)
        
        // start screen
        snapshot("StartScreen")
        let searchButton = app.buttons["searchButton"]
        searchButton.tap()
        
        // search screen
        snapshot("SearchScreen")
        let searchBar = app.otherElements["searchBar"]
        searchBar.tap()
        searchBar.typeText("Mario")
        
        sleep(2)
        
        // search query
        snapshot("SearchQuery")
    }
}
