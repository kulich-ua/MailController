//
//  MailControllerDefaultResultHandler.swift
//  MailController
//
//  Created by Volodymyr Kolibaba on 21.11.18.
//

import Foundation
import MessageUI


public class MailControllerDefaultResultHandler {

    public static func mailComposeController(_ controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: Error?) {

        switch (result) {
            
        case MFMailComposeResult.failed:

            print("Failed to send Email with error: \(error?.localizedDescription ?? "")!")

        default:
            break
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
}
