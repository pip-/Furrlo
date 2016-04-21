//
//  Owner_EditEmail.swift
//  SitStay
//
//  Created by MU IT Program on 4/17/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class Owner_EditEmail: UIViewController {

    @IBOutlet weak var emailField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if let user = appDelegate.getUser(){
            emailField.text = user.email
        
        
            //Saving New Email------------------------
            user.email = "email2@test.com"
            appDelegate.saveContext()
            //----------------------------------------
        }
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
