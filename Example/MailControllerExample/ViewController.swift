//
//  ViewController.swift
//  MailControllerExample
//
//  Created by Volodymyr Kolibaba on 22.11.18.
//  Copyright © 2018 Volodymyr Kolibaba. All rights reserved.
//

import UIKit
import MailController
import MessageUI


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func mailAction() {
        
        if let mailComposeViewController = MailController.shared.mailComposeViewController() {
            
            mailComposeViewController.setToRecipients(["email@example.com"])
            mailComposeViewController.setSubject("Test")
            mailComposeViewController.setMessageBody("Hello world!", isHTML: false)

            present(mailComposeViewController, animated:true, completion:nil)
        }
    }
    
    @IBAction func mailAction2() {
        
        let defaultResultHandler = MailControllerDefaultResultHandler.mailComposeController
        
        if let mailComposeViewController = MailController.shared.mailComposeViewController(defaultResultHandler) {
            
            ViewController.populate(mailComposeViewController: mailComposeViewController)
            present(mailComposeViewController, animated:true, completion:nil)
        }
    }
    
    @IBAction func mailAction3() {
        
        let mailComposeViewController = MailController.shared.mailComposeViewController { (controller, result, error) in
           
            switch (result) {
                
            case MFMailComposeResult.failed:
                
                print("Failed to send Email with error: \(error?.localizedDescription ?? "")!")
                
            default:
                break
            }
            
            controller.dismiss(animated: true, completion: nil)
        }
        
        if let mailComposeViewController = mailComposeViewController {
            
            ViewController.populate(mailComposeViewController: mailComposeViewController)
            present(mailComposeViewController, animated:true, completion:nil)
        }
    }
    
    class func populate(mailComposeViewController: MFMailComposeViewController) {
        
        mailComposeViewController.setToRecipients(["email@example.com"])
        mailComposeViewController.setSubject("Test")
        mailComposeViewController.setMessageBody("Hello world!", isHTML: false)
    }
}

