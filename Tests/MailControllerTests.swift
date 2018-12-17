//
//  MailControllerTests.swift
//  MailControllerTests
//
//  Created by Volodymyr Kolibaba on 13.12.18.
//  Copyright © 2018 Volodymyr Kolibaba. All rights reserved.
//

import XCTest
@testable import MailController

import MessageUI


struct MockMailComposeViewController: MailComposeViewController {

    var mailComposeDelegate: MFMailComposeViewControllerDelegate?
    
    static func canSendMail() -> Bool {
        
        return true
    }
    
    func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        
    }
}

class MailControllerTests: XCTestCase {

    func testWithMFMailComposeViewController() {

        let mailComposeViewController = MailController.shared.mailComposeViewController()
        XCTAssertNil(mailComposeViewController)
    }
    
    func testWithMock() {
        
        let mailComposeViewController = MailController.shared.mailComposeViewController(type: MockMailComposeViewController.self)
        XCTAssertNotNil(mailComposeViewController)        
    }
}
