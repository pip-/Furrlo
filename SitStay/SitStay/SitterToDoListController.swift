//
//  SitterToDoListController.swift
//  SitStay
//
//  Created by MU IT Program on 4/11/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class SitterToDoListController: UIViewController {
    
    @IBOutlet weak var containerView1: UIView!
    @IBOutlet weak var containerView2: UIView!
    @IBOutlet weak var containerView3: UIView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {

      
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //set selected container view that is to be visible based on the segmented controller
        setSelectedView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSelectedView() {
        
        containerView1.hidden = true
        containerView2.hidden = true
        containerView3.hidden = false
        
        if (segmentedControl.selectedSegmentIndex == 0){
            containerView1.hidden = false
            containerView2.hidden = true
            containerView3.hidden = true
            return
        }
        else if (segmentedControl.selectedSegmentIndex == 1){
            containerView1.hidden = true
            containerView2.hidden = false
            containerView3.hidden = true
            return
        }
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
