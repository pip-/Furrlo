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
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var instructionField: UITextField!
    @IBOutlet weak var instructionDetailsField: UITextField!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var complete: NSNumber?
    var instruction: String?
    var instructionDetails: String?
    var itemID: NSNumber?
    var petID: NSNumber?
    var isSat: NSNumber?
    
    
    var pets : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pets.removeAll()
        
        if let fetchedPets = appDelegate.getPets(){
            for pet in fetchedPets{
                pets.append(pet.name!)
            }
        }

        if (pets.count == 0){
            selectionLabel.text = "No pets"
        } else {
        pickerView.selectRow(2, inComponent: 0, animated: false)
        selectionLabel.text = pets[pickerView.selectedRowInComponent(0)]
        }
        
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
        if(pets.count == 0)
        {
            return 1
        }else
        {
            return pets.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pets.count == 0)
        {
            return "No pets"
        } else {
            return pets[row]
        }
      //  return pets[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(pets.count == 0)
        {
            selectionLabel.text = "No pets"
        } else {
        selectionLabel.text = pets[row]
        }
    }
    
    @IBAction func taskSubmitted(sender: AnyObject) {
        
        
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
