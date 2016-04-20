//
//  DatePickerCell.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/20/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class DatePickerCell: UITableViewCell {

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
        // Configure the view for the selected state
    }

    func getPickerDate() -> NSCalendar{
        return datePicker.calendar
    }
}
