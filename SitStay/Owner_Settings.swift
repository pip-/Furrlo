//
//  Owner_Settings.swift
//  SitStay
//
//  Created by MU IT Program on 4/10/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class Owner_Settings: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewOne: UITableView!
    
    var roles = ["Owner", "Sitter"]
    var selectedRow = 0
  

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewOne.registerClass(UITableViewCell.self, forCellReuseIdentifier: "roleCell")
    }
    
    
    func tableView(tableViewOne: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.roles.count;
    }
    
    func tableView(tableViewOne: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableViewOne.dequeueReusableCellWithIdentifier("roleCell")! as UITableViewCell
        
        cell.textLabel?.text = self.roles[indexPath.row]
        
        if (indexPath.row == selectedRow){
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        
        return cell
    }
    func numberOfSectionsInTableView(tableViewOne: UITableView) -> Int {
        return 1
    }
    func tableView(tableViewOne: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.selectedRow = indexPath.row
        tableViewOne.reloadData()
       
       /*
        if let cell = tableViewOne.cellForRowAtIndexPath(indexPath) {
            if cell.accessoryType == .Checkmark
            {
              
                cell.accessoryType = .None
                
            }
            else
            {
                cell.accessoryType = .Checkmark
                
            }
        }*/
        
        
        print("You selected cell #\(indexPath.row)!")
    }
}