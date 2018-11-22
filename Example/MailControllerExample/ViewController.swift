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

    @IBAction func mailAction1() {

        let mailComposeViewController = MailController.shared.mailComposeViewControllerWithCompletion(nil)
        
        if let mailComposeViewController = mailComposeViewController {
            
            ViewController.pupulate(mailComposeViewController: mailComposeViewController)
            present(mailComposeViewController, animated:true, completion:nil)
        }
    }
    
    @IBAction func mailAction2() {
        
        let defaultResultHandler = MailControllerDefaultResultHandler.mailComposeController
        let mailComposeViewController = MailController.shared.mailComposeViewControllerWithCompletion(defaultResultHandler)
        
        if let mailComposeViewController = mailComposeViewController {
            
            ViewController.pupulate(mailComposeViewController: mailComposeViewController)
            present(mailComposeViewController, animated:true, completion:nil)
        }
    }
    
    @IBAction func mailAction3() {
        
        let mailComposeViewController = MailController.shared.mailComposeViewControllerWithCompletion { (controller, result, error) in
            
            controller.dismiss(animated: true, completion: nil)
        }
        
        if let mailComposeViewController = mailComposeViewController {
            
            ViewController.pupulate(mailComposeViewController: mailComposeViewController)
            present(mailComposeViewController, animated:true, completion:nil)
        }
    }
    
    class func pupulate(mailComposeViewController: MFMailComposeViewController) {
        
        mailComposeViewController.setToRecipients(["email@example.com"])
        mailComposeViewController.setSubject("Test")
        mailComposeViewController.setMessageBody("Hello world!", isHTML: false)
    }
}

