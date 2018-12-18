# MailController

[![Build Status](https://travis-ci.org/Kulich-ua/MailController.svg?branch=master)](https://travis-ci.org/Kulich-ua/MailController)
[![Version](https://img.shields.io/cocoapods/v/MailController.svg?style=flat)](https://cocoapods.org/pods/MailController)
[![Platform](https://img.shields.io/cocoapods/p/MailController.svg?style=flat)](https://cocoapods.org/pods/MailController)

MailController is a lightweight Swift wrapper around MFMailComposeViewController, which provides you with a convenient interface.  
It eliminates the use of delegation pattern and instead provides a block-based API if necessary.

MFMailComposeViewController has [issues](https://stackoverflow.com/questions/18165545/why-does-my-mfmailcomposeviewcontroller-instance-only-dismiss-one-time) by reusing, that's why it's not encouraged to do so.  
Instead MailController provides you with a singleton and takes care about releasing of MFMailComposeViewController after dismissing it.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 9.0+ 

## Installation

### CocoaPods

MailController is available through [CocoaPods](https://cocoapods.org). 
To integrate it into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
platform :ios, '9.0'

target '<Your Target Name>' do
    pod 'MailController', '~> 1.0'
end
```

### Source files

Alternatively you can directly add the `Mailcontroller.swift` (and optionaly `MailControllerDefaultResultHandler.swift`) source file to your project.

## Usage

### Quick Start

```swift
import MailController

class ViewController: UIViewController {

    @IBAction func mailAction() {

        if let mailComposeViewController = MailController.shared.mailComposeViewController() {

            mailComposeViewController.setToRecipients(["email@example.com"])
            mailComposeViewController.setSubject("Test")
            mailComposeViewController.setMessageBody("Hello world!", isHTML: false)

            present(mailComposeViewController, animated:true, completion:nil)
        }
    }
}
```

By default when the user has finished with the interface it will be dismissed.  
But you can customize this behaviour and also make use of result and error parameters using completionHandler block:

```swift
    @IBAction func mailAction() {
    
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
        
            present(mailComposeViewController, animated:true, completion:nil)
        }
    }
}
```

## Author

Volodymyr Kolibaba, kulich.ua@gmail.com

## License

MailController is available under the MIT license. See the LICENSE file for more info.
