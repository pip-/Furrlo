//
//  TripCell.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/7/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class TripCell: UITableViewCell {
    
    
    
    @IBOutlet weak var tripLabel: UILabel!
    //@IBOutlet weak var tripLabel: UILabel!
    
    func changeLabel(newLabel: String){
        tripLabel.text = newLabel
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //tripLabel.text = "Initializing..."
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
