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
        print("Send an email!!")
        if let vc = vc{
        //let nc = vc.navigationController
        let mc = MFMailComposeViewController.init()
            mc.mailComposeDelegate = self
            mc.setSubject("Be My Sitter!")
            mc.setMessageBody("Hi there! Join our club", isHTML: false)
            vc.presentViewController(mc, animated: true, completion: nil)
        }
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch(result){
        case MFMailComposeResultCancelled:
            NSLog("Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog("Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog("Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog("Mail sent failure: " + String(error));
            break;
        default:
            break;
        }
        
        if let vc = vc{
            vc.dismissViewControllerAnimated(true, completion: nil)
        }
    }

}
