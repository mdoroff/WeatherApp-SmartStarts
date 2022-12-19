//
//  ThaicomSixPage.swift
//  TemplateProjectUITests
//
//  Created by Eric Waldbaum on 10/13/22.
//

import XCTest

public class ThaicomSixPage: BaseTest {
    override var rootElement: XCUIElement {
        return app.staticTexts["Thaicom 6"]
    }
    
    // Page Elements
    lazy var btnBack = app.buttons["Launches"]
    lazy var strThaicom6 = app.staticTexts["Thaicom 6"]
    lazy var strLaunchSite = app.staticTexts["Launch site:"]
    lazy var strCCAFS_SLC_40 = app.staticTexts["CCAFS SLC 40"]
    lazy var strLaunchDate = app.staticTexts["Launch date:"]
    lazy var str1_6_14 = app.staticTexts["1/6/14"]
    lazy var strMoreDetails = app.staticTexts["More Details:"]
    // TODO: Verify long content descrition
    //lazy var strDetails = app.staticTexts["Second GTO launch for Falcon 9. The USAF evaluated launch data from this flight as part of a separate certification program from SpaceX to qualify to fly U.S. military payloads and found that the Thaicom 6 launch had \" unacceptable fuel reserves at engine cutoff of the stage 2 second burnoff\""]
    
    func verifyHeader(completion: Completion = nil){
        log("Verify Thaicom 6 header text exists")
        XCTAssertTrue(strThaicom6.exists)
    }
    
    func verifyBody(completion: Completion = nil){
        log("Verify Launch Site exists")
        XCTAssertTrue(strLaunchSite.exists)
        
        log("Verify CCAFS SLC 40 exists")
        XCTAssertTrue(strCCAFS_SLC_40.exists)
        
        log("Verify Launch Date exists")
        XCTAssertTrue(strLaunchDate.exists)
        
        log("Verify 1/6/14 text exists")
        XCTAssertTrue(str1_6_14.exists)
        
        log("Verify More Details exists")
        XCTAssertTrue(strMoreDetails.exists)
    }
    
    func tapBackButton(completion: Completion = nil){
        log("Verify Launches back button text exists")
        XCTAssertTrue(btnBack.exists)
        
        log("Tap Launches back button")
        btnBack.tap()
    }
}
