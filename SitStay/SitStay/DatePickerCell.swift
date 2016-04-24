//
//  DatePickerCell.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/20/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class DatePickerCell: UITableViewCell {
    
    weak var parentTableViewController: NewTripOwnerController?

    @IBOutlet weak var datePicker: UIDatePicker!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        //let calendar = NSCalendar.currentCalendar()
        datePicker.setDate(NSDate(), animated: true)
        datePicker.minuteInterval = 15
        datePicker.minimumDate = NSDate.init()
        // Configure the view for the selected state
    }

    func getPickerDate() -> NSCalendar{
        return datePicker.calendar
    }
    
    func setPTVController(vc: NewTripOwnerController){
        self.parentTableViewController = vc
    }
    
    @IBAction func updateParentDate(sender: UIDatePicker) {
        if let view = parentTableViewController{
            if(view.rowSelected == 0){
                view.startDate = datePicker.date
            } else if(view.rowSelected == 2){
                view.endDate = datePicker.date
            }
            view.tableView.reloadRowsAtIndexPaths([NSIndexPath.init(forRow: 0, inSection: 0), NSIndexPath.init(forRow: 2, inSection: 0)], withRowAnimation: .Fade)
            view.checkIfCanSubmit()
        }
    }
}
