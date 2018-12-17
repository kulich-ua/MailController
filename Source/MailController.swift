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
    private var mailComposeViewController: MailComposeViewController? = nil
    
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

        let mailViewController = self.mailComposeViewController(type: MFMailComposeViewController.self, completionHandler: completionHandler)
        return mailViewController as? MFMailComposeViewController
    }

    // MARK: Internal logic
    
    func mailComposeViewController(type mailComposeViewControllerType: MailComposeViewController.Type, completionHandler: CompletionHandler? = nil) -> MailComposeViewController? {
        
        if mailComposeViewControllerType.canSendMail() {
            
            dismissViewController()
            
            self.completionHandler = completionHandler
            
            var mailComposeViewController = mailComposeViewControllerType.init()
            mailComposeViewController.mailComposeDelegate = self
            
            self.mailComposeViewController = mailComposeViewController
            
            return mailComposeViewController
            
        } else {
            
            MailController.openMailApp()
        }
        
        return nil
    }

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
