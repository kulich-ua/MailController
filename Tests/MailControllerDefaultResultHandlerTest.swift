//
//  MailControllerDefaultResultHandlerTest.swift
//  MailControllerTests
//
//  Created by Volodymyr Kolibaba on 18.12.18.
//  Copyright © 2018 Volodymyr Kolibaba. All rights reserved.
//

import XCTest
@testable import MailController

class MailControllerDefaultResultHandlerTest: XCTestCase {

    func testWithMock() {
        
        let defaultResultHandler = MailControllerDefaultResultHandler.mailComposeController

        let mockMailComposeViewController = MailControllerTests.mockMailComposeViewController(defaultResultHandler)
        XCTAssertEqual(mockMailComposeViewController.dismissCount, 0)
        
        let mailController = MailController.shared
        
        mailController.mailComposeController(mockMailComposeViewController, didFinishWith: .failed, error: nil)
        XCTAssertEqual(mockMailComposeViewController.dismissCount, 1)
    }
}
