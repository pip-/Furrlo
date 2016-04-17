//
//  SettingsOwner.swift
//  SitStay
//
//  Created by MU IT Program on 4/10/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class SettingsOwner: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewOne: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    
    var roles = ["Owner", "Sitter"]
    var contactInfo = ["Phone", "Email"]
    var selectedRow = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewOne.registerClass(UITableViewCell.self, forCellReuseIdentifier: "roleCell")
        self.tableView2.registerClass(UITableViewCell.self, forCellReuseIdentifier: "contactCell")
        
        

    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewOne {
            return self.roles.count
        } else {
        return self.contactInfo.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == tableViewOne {
        let cell:UITableViewCell = self.tableViewOne.dequeueReusableCellWithIdentifier("roleCell")! as UITableViewCell
        
        cell.textLabel?.text = self.roles[indexPath.row]
        
        if (indexPath.row == selectedRow){
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }; return cell
        }
        else{
            let cell:UITableViewCell = self.tableView2.dequeueReusableCellWithIdentifier("contactCell")! as UITableViewCell
            
            cell.textLabel?.text = self.contactInfo[indexPath.row]
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            
            
            return cell
        }
        
       
    }
    
    

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == tableViewOne{
        
        self.selectedRow = indexPath.row
        if(indexPath.row == 1){
            self.changeBoard()
        }
        tableViewOne.reloadData()
        }
        
        
        
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
    func changeBoard(){
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "changingSettings")
        let storyboard = UIStoryboard(name: "Sitter", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("tabBarControllerSitter")
        presentViewController(vc, animated: false, completion: nil)
    }
}