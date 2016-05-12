//
//  DateEntryCell.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/21/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class DateEntryCell: UITableViewCell, UITextFieldDelegate {

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
        textField.selected = true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        changedData(textField)
        textFieldShouldReturn(textField)
    }
    
    @IBAction func changedData(sender: UITextField) {
        //textField.becomeFirstResponder()
        textField.resignFirstResponder()
        if let vc = parentViewController{
            if let type = typeEditing{
                if(type == "street"){
                    vc.street = sender.text
                } else if(type == "address2"){
                    vc.address2 = sender.text
                } else if(type == "zip"){
                    vc.zip = sender.text!
                } else if(type == "city"){
                    vc.city = sender.text
                } else if(type == "tripName"){
                    vc.tripName = sender.text
                }
            }
            vc.tableView.reloadRowsAtIndexPaths([NSIndexPath.init(forRow: 4, inSection: 2)], withRowAnimation: .Fade)
            parentViewController?.checkIfCanSubmit()
        }
    }
    
    func setPTVController(vc: NewTripOwnerController, type: String){
        self.parentViewController = vc
        self.typeEditing = type
        if(type == "street"){
            if let street = vc.street{
                textField.text = street
            }
        } else if(type == "add2"){
            if let add2 = vc.address2{
                textField.text = add2
            }
        } else if(type == "zip"){
            if let zip = vc.zip{
                textField.text = zip
            }
        } else if(type == "city"){
            if let city = vc.city{
                textField.text = city
            }
        } else if(type == "tripName"){
            if let tripName = vc.tripName{
                textField.text = tripName
            }
        }
    }

}
