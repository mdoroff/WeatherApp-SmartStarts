//
//  BaseTest.swift
//  TemplateProjectUITests
//
//  Created by Eric Waldbaum on 10/13/22.
//

import XCTest

class Logger {
    func log(_ mlog: String)
    {
        NSLog(mlog)
    }
}

public class BaseTest {
    typealias Completion = (() -> Void)?
    let app = XCUIApplication(bundleIdentifier: "com.deloitte.GraphQL-Example")
    let log = Logger().log
    required init(timeout: TimeInterval = 10, completion: Completion = nil) {
        log("Waiting \(timeout)s for \(String(describing: self)) existence")
        XCTAssert(rootElement.waitForExistence(timeout: timeout),
              "Page \(String(describing: self)) waited, but not loaded")
        completion?()
    }
    
    var rootElement: XCUIElement {
        fatalError("subclass should override rootElement")
    }
    
    // Button
    func button(_ name: String) -> XCUIElement {
        return app.buttons[name]
    }
    
    // Navigation bar
    func navBar(_ name: String) -> XCUIElement {
        return app.navigationBars[name]
    }
    
    // SecureField
    func secureField(_ name: String) -> XCUIElement {
        return app.secureTextFields[name]
    }
    
    // TextField
    func textField(_ name: String) -> XCUIElement {
        return app.textFields[name]
    }
    
    // TextView
    func textView(_ name: String) -> XCUIElement {
        return app.textViews[name]
    }
    
    // Text
    func text(_ name: String) -> XCUIElement {
        return app.staticTexts[name]
    }
    
    // WebView
    func webView(_ name: String) -> XCUIElement {
        return app.webViews[name]
    }
    
    // Key
    func key(_ name: String) -> XCUIElement {
        return app.keys[name]
    }
    
    // Image
    func image(_ name: String) -> XCUIElement {
        return app.images[name]
    }

    func setText(_ text: String, on element: XCUIElement?) {
        if let element = element {
            UIPasteboard.general.string = text
            element.doubleTap()
        }
    }
}
