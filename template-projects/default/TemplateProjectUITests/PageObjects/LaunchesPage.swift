//
//  LaunchesPage.swift
//  TemplateProjectUITests
//
//  Created by Eric Waldbaum on 10/13/22.
//

import XCTest

public class LaunchesPage: BaseTest {
    override var rootElement: XCUIElement {
        return app.staticTexts["Launches"]
    }
    
    // Page Elements
    lazy var strLaunches = app.staticTexts["Launches"]
    lazy var strThaicom6 = app.staticTexts["Thaicom 6"]
    lazy var str1_6_14 = app.staticTexts["1/6/14"]
    
    func verifyHeader(completion: Completion = nil){
        log("Verify Launches header text exists")
        XCTAssertTrue(strLaunches.exists)
    }
    
    func tapThaicom6(completion: Completion = nil) {
        if strThaicom6.waitForExistence(timeout: 5){
            log("Verify Thaicom 6 text exists")
            XCTAssertTrue(strThaicom6.exists)
        }
        
        log("Verify 1/6/14 text exists")
        XCTAssertTrue(str1_6_14.exists)
        
        log("Tap Thaicom 6 list item text")
        strThaicom6.tap()
    }
}
