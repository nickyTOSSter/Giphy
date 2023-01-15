
import XCTest


final class GiphyUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app.terminate()
        app = nil
    }
    
    
    
    func testDislikeButton() throws {
        let firstGif = app.images["gif"]
        app.buttons["dislikeBtn"].tap()
        sleep(3)
        let secondGif = app.images["gif"]
        let counterLabel = app.staticTexts["counterLabel"]
        
        XCTAssertTrue(counterLabel.label == "2/10")
        XCTAssertFalse(firstGif == secondGif)
    }
    
    func testEndGameAlert() throws {
        tapButtonUntilGameNotFinished(btnIdentifier: "dislikeBtn")
        let endOfTheGameAlert = app.alerts["endOfTheGame"]
        XCTAssertTrue(endOfTheGameAlert.exists)
        let alertBtn = endOfTheGameAlert.buttons.firstMatch
        XCTAssertNotNil(alertBtn)
        XCTAssertEqual(alertBtn.label, "Хочу посмотреть еще гифок")
    }
    
    func testAlertDismis() throws {
        tapButtonUntilGameNotFinished(btnIdentifier: "dislikeBtn")
        let endOfTheGameAlert = app.alerts["endOfTheGame"]
        XCTAssertTrue(endOfTheGameAlert.exists)
        let alertBtn = endOfTheGameAlert.buttons.firstMatch
        XCTAssertNotNil(alertBtn)
        alertBtn.tap()
        sleep(2)
        let alertAfterDismiss = app.alerts["endOfTheGame"]
        XCTAssertFalse(alertAfterDismiss.exists)
        
        let counterLabel = app.staticTexts["counterLabel"]
        XCTAssertTrue(counterLabel.label == "1/10")

    }
    
    
    func invokeEndOfTheGameAlert() -> XCUIElement? {
        let dislikeBtn = app.buttons["dislikeBtn"]
        for _ in 1...10 {
            dislikeBtn.tap()
            sleep(2)
        }
        return app.alerts["endOfTheGame"]
    }
    
    func tapButtonUntilGameNotFinished(btnIdentifier: String) {
        let btn = app.buttons[btnIdentifier]
        for _ in 1...10 {
            btn.tap()
            sleep(2)
        }
    }
}
