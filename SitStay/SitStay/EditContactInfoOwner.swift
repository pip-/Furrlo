//
//  Owner_EditContactInfo.swift
//  Pet_Tab
//
//  Created by MU IT Program on 3/29/16.
//  Copyright © 2016 Megan Cochran. All rights reserved.
//

import UIKit

class EditContactInfoOwner: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Edit"

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

    @IBAction func cancel(sender: AnyObject) {
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func done(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
}
