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
    
    func testTakeScreens() {
        let app = XCUIApplication()
        sleep(1)
        
        // start screen
        snapshot("StartScreen")
        app.buttons["searchButton"].tap()
        
        // platform select screen
        snapshot("PlatformSelectScreen")
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["N64"]/*[[".cells.staticTexts[\"N64\"]",".staticTexts[\"N64\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // search screen
        let searchQuerySearchField = app/*@START_MENU_TOKEN@*/.searchFields["Search query..."]/*[[".otherElements[\"searchBar\"].searchFields[\"Search query...\"]",".searchFields[\"Search query...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        searchQuerySearchField.tap()
        searchQuerySearchField.typeText("harvest")
        sleep(2)
        snapshot("SearchScreen")
        
        // game detail screen
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["February 05, 1999"]/*[[".cells.staticTexts[\"February 05, 1999\"]",".staticTexts[\"February 05, 1999\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("GameDetailScreen")
    }
}
