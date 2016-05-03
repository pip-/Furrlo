//
//  OwnerAddListViewController.swift
//  SitStay
//
//  Created by Michael Mclaughlin on 4/29/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class OwnerAddListViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var selectionLabel: UILabel!
    
    var pets : [String] = ["Mira","Tony","Jade"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.selectRow(2, inComponent: 0, animated: false)
        selectionLabel.text = pets[pickerView.selectedRowInComponent(0)]
        
        
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
        return pets.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pets[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectionLabel.text = pets[row]
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
