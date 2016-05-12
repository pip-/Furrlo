//
//  InviteSitterCell.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/24/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit
import MessageUI

class InviteSitterCell: UITableViewCell, MFMailComposeViewControllerDelegate {

    var vc: ViewTripOwner? = nil
    var tripID: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func setParentController(vc: ViewTripOwner){
        self.vc = vc
    }
    
    //override func
    @IBAction func sendEmail(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.vc!.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
        
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([])
        mailComposerVC.setSubject("Be My Pet Sitter!")
        mailComposerVC.setMessageBody("Hello! I am looking forward to having you as my pet sitter! So we can keep in touch, please download Furrlo on the App Store! Then confirm our trip using the Trip ID: " + String(self.tripID) + " Thanks!", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
