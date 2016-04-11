//
//  NavControllerPetsOwner.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/11/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class NavControllerPetsOwner: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let changingSettings = NSUserDefaults.standardUserDefaults().boolForKey("changingSettings")
        if(changingSettings){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let newVC = storyboard.instantiateViewControllerWithIdentifier("settingsOwner")
            self.pushViewController(newVC, animated: false)
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "changingSettings")
        }
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
