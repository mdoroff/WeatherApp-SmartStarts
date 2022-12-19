//
//  E2E_LaunchesTests.swift
//  TemplateProjectUITests
//
//  Created by Eric Waldbaum on 10/13/22.
//

import XCTest

class E2ELaunchesTests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication(bundleIdentifier: "com.deloitte.SpaceXLaunches").launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchesE2E() throws {
        // This is an example of a functional test case.
        LaunchesPage().verifyHeader()
        LaunchesPage().tapThaicom6()
        ThaicomSixPage().verifyHeader()
        ThaicomSixPage().verifyBody()
        ThaicomSixPage().tapBackButton()
        LaunchesPage().verifyHeader()
    }

    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        // TODO: Add baseline average to test against
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication(bundleIdentifier: "com.deloitte.SpaceXLaunches").launch()
        }
    }
    
    func testLaunchesPerformanceMetricOptions() {
        let metrics: [XCTMetric] = [XCTMemoryMetric(), XCTStorageMetric(), XCTClockMetric()]
        
        let measureOptions = XCTMeasureOptions.default
        measureOptions.iterationCount = 3
        
        measure(metrics: metrics, options: measureOptions) {
            try? E2ELaunchesTests().testLaunchesE2E()
        }
    }
}
