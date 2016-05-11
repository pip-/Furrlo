//
//  TabBarControllerOwner.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/11/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class TabBarControllerOwner: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 1
        // Do any additional setup after loading the view.
        
        if(NSUserDefaults.standardUserDefaults().boolForKey("isSitter")){
            let storyboard = UIStoryboard(name: "Sitter", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("tabBarControllerSitter")
            presentViewController(vc, animated: false, completion: nil)
        }
        
        self.tabBar.tintColor = UIColor.init(red: 13/255, green: 155/255, blue: 141/255, alpha: 1)
    }
    
    override func viewDidAppear(animated: Bool) {
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
