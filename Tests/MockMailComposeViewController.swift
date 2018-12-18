//
//  MockMailComposeViewController.swift
//  MailController
//
//  Created by Volodymyr Kolibaba on 18.12.18.
//  Copyright © 2018 Volodymyr Kolibaba. All rights reserved.
//

import Foundation
import MessageUI
@testable import MailController


class MockMailComposeViewController: MailComposeViewController {
    
    public var dismissCount = 0
    
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
