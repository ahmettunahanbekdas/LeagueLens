//
//  LeagueLensUITestsLaunchTests.swift
//  LeagueLensUITests
//
//  Created by Ahmet Tunahan Bekdaş on 23.04.2024.
//

import XCTest

final class LeagueLensUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()


        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
