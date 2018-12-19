//
//  MailController.swift
//  MailController
//
//  Created by Volodymyr Kolibaba on 21.11.18.
//

import Foundation
import MessageUI

/// Lightweight Swift wrapper around MFMailComposeViewController
public class MailController: NSObject {
    
    /// A closure executed upon user's completion of email composition.
    /// The closure takes the same arguments as `MFMailComposeViewControllerDelegate`
    public typealias CompletionHandler = (_ controller: MailComposeViewController, _ result: MFMailComposeResult, _ error: Error?) -> Void

    private var completionHandler: CompletionHandler? = nil
    private var mailComposeViewController: MailComposeViewController? = nil
    
    // MARK: Public interface
    
    /// Returns the singleton mail controller instance.
    ///
    /// - Returns: The shared `MailController` instance.
    public static let shared = MailController()

    /// Attempts to open the Mail app.
    public static func openMailApp() {

        guard let mailToURL = URL(string: "mailto:") else {
         
            assertionFailure("Failed to create mailToURL!")
            return
        }
        UIApplication.shared.openURL(mailToURL)
    }

    /// Creates a new instance of `MFMailComposeViewController`
    ///
    /// Invoking this method causes the mail controller to create and return a new instance of `MFMailComposeViewController`.
    /// This new instance is associated with the mail controller directly and will be released upon user's completion of email composition
    /// or by next call of this method.
    ///
    /// - Parameter completionHandler: Closure which is called upon user's completion of email composition.
    ///
    ///   `CompletionHandler` provides the same information as `MFMailComposeViewControllerDelegate`.
    ///   Upon this call, the client should remove the view associated with the controller, typically by dismissing modally.
    ///   If `nil`, `MFMailComposeViewController` will be dismissed when the user has finished with the interface.
    ///
    /// - Returns: A newly created instance of `MFMailComposeViewController`.
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
}

// MARK: Private logic

private extension MailController {
    
    func reset() {

        completionHandler = nil
        mailComposeViewController = nil
    }

    func dismissViewController () {

        if let mailComposeViewController = self.mailComposeViewController {

            mailComposeViewController.dismiss(animated: true, completion: nil)
        }
        reset()
    }
}

/// Mail controller eliminates the use of delegation pattern and instead provides a block-based API if necessary.
extension MailController: MFMailComposeViewControllerDelegate {

    // Workaround for bug: https://bugs.swift.org/browse/SR-7235
    @objc (mailComposeController:didFinishWithResult:error:)
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {

        let mailComposeViewController = controller as MailComposeViewController
        mailComposeController(mailComposeViewController, didFinishWith: result, error: error)
    }
    
    func mailComposeController(_ controller: MailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let completionHandler = self.completionHandler {
            
            completionHandler(controller, result, error)
            
        } else {
            
            dismissViewController()
        }
        reset()
    }
}
