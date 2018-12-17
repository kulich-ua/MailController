//
//  MailComposeViewController.swift
//  MailController
//
//  Created by Volodymyr Kolibaba on 14.12.18.
//  Copyright © 2018 Volodymyr Kolibaba. All rights reserved.
//

import Foundation
import MessageUI

protocol MailComposeViewController {
    
    var mailComposeDelegate: MFMailComposeViewControllerDelegate? {get set}
    
    init()
    
    static func canSendMail() -> Bool
        
    func dismiss(animated flag: Bool, completion: (() -> Void)?)
}

extension MFMailComposeViewController: MailComposeViewController {
    
}
