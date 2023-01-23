//
//  ReverseUITests.swift
//  ReverseUITests
//
//  Created by Konstantyn Koroban on 04/11/2022.
//

import XCTest

class ReverseUITests: XCTestCase {
    
    var textView: XCUIElement!
    var app: XCUIApplication!
    
    override func setUp()  {
        super.setUp()
        app = XCUIApplication()
        textView = app.textViews["resultTextView"]
        continueAfterFailure = false
        app.launch()
    }
    
    func testUIViewsExist() {
        XCTAssertTrue(app.textFields["reverseTextField"].exists)
        XCTAssertFalse(app.staticTexts["resultLabel"].exists)
        XCTAssertTrue(app.segmentedControls.element.exists)
        XCTAssertTrue(app.staticTexts["allCharactersLabel"].exists)
        XCTAssertFalse(app.textFields["ignoreCharactersTextField"].exists)
    }
    
    func testDefaultExclusion() {
        enterStringInTextFieldById(phrase: "Foxminded cool 24/7", id: "reverseTextField")
        let expectedOutcome = "dednimxoF looc 24/7"
        XCTAssertEqual(textView.value as! String, expectedOutcome)
    }
    
    func testCustomExclusionLetters() {
        enterStringInTextFieldById(phrase: "Foxminded cool 24/7", id: "reverseTextField")
        let expectedOutcome = "dexdnimoF oocl 7/42"
        app.segmentedControls["switchCondition"].buttons["Custom"].tap()
        enterStringInTextFieldById(phrase: "xl", id: "ignoreCharactersTextField")
        XCTAssertEqual(textView.value as! String, expectedOutcome)
    }
    
    func testCustomExclusionDigits() {
        enterStringInTextFieldById(phrase: "Foxminded cool 24/7", id: "reverseTextField")
        let expectedOutcome = "dednimxoF looc /427"
        app.segmentedControls["switchCondition"].buttons["Custom"].tap()
        enterStringInTextFieldById(phrase: "1370", id: "ignoreCharactersTextField")
        XCTAssertEqual(textView.value as! String, expectedOutcome)
    }
    
    func testCustomExclusionSymbols() {
        enterStringInTextFieldById(phrase: "Foxminded cool 24/7", id: "reverseTextField")
        let expectedOutcome = "dednimxoF looc 74/2"
        app.segmentedControls["switchCondition"].buttons["Custom"].tap()
        enterStringInTextFieldById(phrase: "/", id: "ignoreCharactersTextField")
        XCTAssertEqual(textView.value as! String, expectedOutcome)
    }
    
    func testSegmentedControlTapChangeViews() {
        XCTAssertTrue(app.staticTexts["allCharactersLabel"].exists)
        XCTAssertFalse(app.textFields["ignoreCharactersTextField"].exists)
        app.segmentedControls["switchCondition"].buttons["Custom"].tap()
        XCTAssertFalse(app.staticTexts["allCharactersLabel"].exists)
        XCTAssertTrue(app.textFields["ignoreCharactersTextField"].exists)
    }
    
    func test_defaultExclusion_customExclusion() {
        enterStringInTextFieldById(phrase: "Foxminded cool 24/7", id: "reverseTextField")
        var expectedOutcome = "dednimxoF looc 24/7"
        XCTAssertEqual(textView.value as! String, expectedOutcome)
        app.segmentedControls["switchCondition"].buttons["Custom"].tap()
        enterStringInTextFieldById(phrase: "Foxminded", id: "ignoreCharactersTextField")
        expectedOutcome = "Foxminded looc 7/42"
        XCTAssertEqual(textView.value as! String, expectedOutcome)
        app.segmentedControls["switchCondition"].buttons["Default"].tap()
        expectedOutcome = "dednimxoF looc 24/7"
        XCTAssertEqual(textView.value as! String, expectedOutcome)
        app.segmentedControls["switchCondition"].buttons["Custom"].tap()
        expectedOutcome = "Foxminded looc 7/42"
        XCTAssertEqual(textView.value as! String, expectedOutcome)
    }
    
    private func enterStringInTextFieldById(phrase: String, id: String) {
        let textField = app.textFields[id]
        textField.tap()
        textField.typeText(phrase)
    }
    
    private func clearTextField(id: String) {
        app.textFields[id].press(forDuration: 1.2)
        app.menuItems["Select All"].tap()
        app.menuItems["Cut"].tap()
    }
}

