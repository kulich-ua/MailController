//
//  MailComposeViewController.swift
//  MailController
//
//  Created by Volodymyr Kolibaba on 14.12.18.
//  Copyright © 2018 Volodymyr Kolibaba. All rights reserved.
//

import Foundation
import MessageUI

/// Protocol used to be able to test mail controller using dependency injection
/// since MFMailComposeViewController doesn't work in iOS Simulator.
public protocol MailComposeViewController {
    
    var mailComposeDelegate: MFMailComposeViewControllerDelegate? {get set}
    
    init()
    
    static func canSendMail() -> Bool
        
    func dismiss(animated flag: Bool, completion: (() -> Void)?)
}

extension MFMailComposeViewController: MailComposeViewController {
    
}
