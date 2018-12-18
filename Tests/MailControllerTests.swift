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


class MailControllerTests: XCTestCase {
    
    func testWithMFMailComposeViewController() {

        let mailComposeViewController = MailController.shared.mailComposeViewController()
        XCTAssertNil(mailComposeViewController)
    }
    
    func testWithMock() {
        
        let firstMockMailComposeViewController = MailControllerTests.mockMailComposeViewController()
        XCTAssertEqual(firstMockMailComposeViewController.dismissCount, 0)

        let secondMockMailComposeViewController = MailControllerTests.mockMailComposeViewController()
        XCTAssertEqual(secondMockMailComposeViewController.dismissCount, 0)
        XCTAssertEqual(firstMockMailComposeViewController.dismissCount, 1)
        
        XCTAssertTrue(firstMockMailComposeViewController !== secondMockMailComposeViewController)
        
        let mailController = MailController.shared
        
        mailController.mailComposeController(secondMockMailComposeViewController, didFinishWith: .cancelled, error: nil)
        XCTAssertEqual(secondMockMailComposeViewController.dismissCount, 1)
    }
    
    //MARK: Internal logic
    
    class func mockMailComposeViewController(_ completionHandler: CompletionHandler? = nil) -> MockMailComposeViewController {
        
        let mailComposeViewControllerType = MockMailComposeViewController.self
        let mailController = MailController.shared
        
        let mailComposeViewController = mailController.mailComposeViewController(type: mailComposeViewControllerType, completionHandler: completionHandler)
        XCTAssertNotNil(mailComposeViewController)
        
        guard let mockMailComposeViewController = mailComposeViewController as? MockMailComposeViewController else {
            
            fatalError("mailComposeViewController should of type MockMailComposeViewController!")
        }
        
        XCTAssertTrue(mockMailComposeViewController.mailComposeDelegate === MailController.shared)
        
        XCTAssertEqual(mockMailComposeViewController.dismissCount, 0)

        return mockMailComposeViewController
    }
}
