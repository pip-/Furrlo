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
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func changedData(sender: UITextField) {
        if let vc = parentViewController{
                    vc.tripName = sender.text
            vc.tableView.reloadRowsAtIndexPaths([NSIndexPath.init(forRow: 4, inSection: 1)], withRowAnimation: .Fade)
            parentViewController?.checkIfCanSubmit()
        }
    }
    
    func setPTVController(vc: NewTripOwnerController, type: String){
        self.parentViewController = vc
        if let tripName = vc.tripName{
            textField.text = tripName
        }
    }
    
}
