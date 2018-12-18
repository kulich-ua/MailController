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

typealias CompletionHandler = MailController.CompletionHandler


class MockMailComposeViewController: MailComposeViewController {

    var dismissCount = 0
    
    var mailComposeDelegate: MFMailComposeViewControllerDelegate?
    
    required init() {
    }
    
    static func canSendMail() -> Bool {
        
        return true
    }
    
    func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        
        dismissCount += 1
    }
}

class MailControllerTests: XCTestCase {
    
    func testWithMFMailComposeViewController() {

        let mailComposeViewController = MailController.shared.mailComposeViewController()
        XCTAssertNil(mailComposeViewController)
    }
    
    func testWithMock() {
        
        let firstMockMailComposeViewController = mockMailComposeViewController()
        XCTAssertEqual(firstMockMailComposeViewController.dismissCount, 0)

        let secondMockMailComposeViewController = mockMailComposeViewController()
        XCTAssertEqual(secondMockMailComposeViewController.dismissCount, 0)
        XCTAssertEqual(firstMockMailComposeViewController.dismissCount, 1)
        
        XCTAssertTrue(firstMockMailComposeViewController !== secondMockMailComposeViewController)
    }
    
    //MARK: Internal logic
    
    func mockMailComposeViewController(_ completionHandler: CompletionHandler? = nil) -> MockMailComposeViewController {
        
        let mailComposeViewControllerType = MockMailComposeViewController.self
        
        let mailComposeViewController = MailController.shared.mailComposeViewController(type: mailComposeViewControllerType)
        XCTAssertNotNil(mailComposeViewController)
        
        guard let mockMailComposeViewController = mailComposeViewController as? MockMailComposeViewController else {
            
            fatalError("mailComposeViewController should of type MockMailComposeViewController!")
        }
        
        XCTAssertTrue(mockMailComposeViewController.mailComposeDelegate === MailController.shared)
        
        XCTAssertEqual(mockMailComposeViewController.dismissCount, 0)

        return mockMailComposeViewController
    }
}
