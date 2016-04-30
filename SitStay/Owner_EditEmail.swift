//
//  Owner_EditEmail.swift
//  SitStay
//
//  Created by MU IT Program on 4/17/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class Owner_EditEmail: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let user = appDelegate.getUser(){
            if let email = user.email{
                emailField.text = email
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if let user = appDelegate.getUser(){
            if let email = user.email{
                emailField.text = email
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editingEnded(sender: AnyObject) {
        self.resignFirstResponder()
        updateEmail()
    }

    @IBAction func touchUpOutside(sender: AnyObject) {
        self.resignFirstResponder()
        updateEmail()
    }
    
    @IBAction func touchDragOutside(sender: AnyObject) {
        self.resignFirstResponder()
        updateEmail()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        updateEmail()
        textFieldShouldReturn(textField)
    }
    
    func updateEmail(){
        if let email = emailField.text{
            appDelegate.updateUserEmail(email)
            print("Updated email")
        }
        
    }

}
