//
//  OwnerAddTaskViewController.swift
//  SitStay
//
//  Created by Michael Mclaughlin on 4/26/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class OwnerAddTaskViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var taskPicker: UIPickerView!
    @IBOutlet weak var selectionLabel: UILabel!
    
     var tasks : [String] = ["Food","Water","Exercise","Medicine","Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskPicker.dataSource = self
        taskPicker.delegate = self
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tasks.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tasks[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectionLabel.text = tasks[row]
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
