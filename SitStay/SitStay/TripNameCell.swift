//
//  DateEntryCell.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/21/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class TripNameCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    weak var parentViewController: NewTripOwnerController?
    var typeEditing: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func changedData(sender: UITextField) {
        textField.resignFirstResponder()
        if let vc = parentViewController{
                vc.tripName = sender.text
            parentViewController?.checkIfCanSubmit()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        changedData(textField)
        textFieldShouldReturn(textField)
    }
    
    func setPTVController(vc: NewTripOwnerController, type: String){
        self.parentViewController = vc
        if let tripName = vc.tripName{
            textField.text = tripName
        }
    }
    
}
