//
//  Owner_EditPhone.swift
//  SitStay
//
//  Created by MU IT Program on 4/17/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class Owner_EditPhone: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        phoneTextField.delegate = self
        if let user = appDelegate.getUser(){
            if let phone = user.phone{
                phoneTextField.text = phone
                
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if let user = appDelegate.getUser(){
            if let phone = user.phone{
                phoneTextField.text = phone
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        updatePhone()
        textFieldShouldReturn(textField)
    }

    @IBAction func editingEnded(sender: AnyObject) {
        self.resignFirstResponder()
        updatePhone()
    }
    
    
    func updatePhone(){
        if let phone = phoneTextField.text{
            appDelegate.updateUserPhone(phone)
            print("Updated phone")
            
        }
        
    }

}
