//
//  SimpleCell.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/17/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class SimpleCell: UITableViewCell {

    @IBOutlet weak var detailLabel: UILabel!

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func changeTitle(name: String){
        self.titleLabel.text = name
    }
    func changeDetail(content: String){
        self.detailLabel.text = content
    }
}
