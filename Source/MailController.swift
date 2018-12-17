//
//  MailController.swift
//  MailController
//
//  Created by Volodymyr Kolibaba on 21.11.18.
//

import Foundation
import MessageUI


public class MailController: NSObject {
    
    public typealias CompletionHandler = (_ controller: MFMailComposeViewController, _ result: MFMailComposeResult, _ error: Error?) -> Void

    private var completionHandler: CompletionHandler? = nil
    private var mailComposeViewController: MFMailComposeViewController? = nil
    
    // MARK: Public interface

    public static let shared = MailController()

    public static func openMailApp() {

        guard let mailToURL = URL(string: "mailto:") else {
         
            assertionFailure("Failed to create mailToURL!")
            return
        }
        UIApplication.shared.openURL(mailToURL)
    }

    public func mailComposeViewController(_ completionHandler: CompletionHandler? = nil) -> MFMailComposeViewController? {

        if MFMailComposeViewController.canSendMail() {
            
            dismissViewController()
            
            self.completionHandler = completionHandler
            
            let mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.mailComposeDelegate = self
            
            self.mailComposeViewController = mailComposeViewController
            
            return mailComposeViewController
            
        } else {
            
            MailController.openMailApp()
        }
        
        return nil
    }

    // MARK: Internal logic

    private func reset() {

        completionHandler = nil
        mailComposeViewController = nil
    }

    private func dismissViewController () {

        if let mailComposeViewController = self.mailComposeViewController {

            mailComposeViewController.dismiss(animated: true, completion: nil)
        }
        reset()
    }
}

extension MailController: MFMailComposeViewControllerDelegate {

    // Workaround for bug: https://bugs.swift.org/browse/SR-7235
    @objc (mailComposeController:didFinishWithResult:error:)
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {

        if let completionHandler = self.completionHandler {
            
            completionHandler(controller, result, error)
            
        } else {
            
            dismissViewController()
        }
        reset()
    }
}
