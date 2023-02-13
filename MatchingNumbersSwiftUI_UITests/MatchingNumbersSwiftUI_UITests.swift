//
//  MatchingNumbersSwiftUI_UITests.swift
//  MatchingNumbersSwiftUI_UITests
//
//  Created by Maxim Lobovich on 24/01/2023.
//

import XCTest

final class MatchingNumbersSwiftUI_UITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
    }

    func test_IntroScreen_tapContinueBtn_navigateNumbersScreen() throws {
        let continueBtn = app.buttons["Continue"]
        continueBtn.tap()
 
        let navBar = app.navigationBars["Numbers Screen"]
        XCTAssertTrue(navBar.exists)
    }
    
    func test_NumbersView_tapReturnBtn_navigateIntroScreen() throws {
        let continueBtn = app.buttons["Continue"]
        continueBtn.tap()

        let navBar = app.navigationBars["Numbers Screen"]
        let returnBtn = navBar.buttons["Back"]
        returnBtn.tap()
        
        let introScreenText = app.staticTexts["Intro Screen"]
        XCTAssertTrue(introScreenText.exists)
                
    }

}
