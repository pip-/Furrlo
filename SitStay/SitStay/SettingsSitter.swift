//
//  SettingsSitter.swift
//  SitStay
//
//  Created by MU IT Program on 4/10/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class SettingsSitter: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewOne: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    
    var roles = ["Owner", "Sitter"]
    var selectedRow = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewOne.registerClass(UITableViewCell.self, forCellReuseIdentifier: "roleCell")
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewOne {
            return self.roles.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell:UITableViewCell = self.tableViewOne.dequeueReusableCellWithIdentifier("roleCell")! as UITableViewCell
            
            cell.textLabel?.text = self.roles[indexPath.row]
            
            if (indexPath.row == selectedRow){
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
            return cell
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if tableView == tableViewOne{
            
            self.selectedRow = indexPath.row
            if(indexPath.row == 0){
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
        
        
        print("You selected cell #\(indexPath.row)!")    }
    func changeBoard(){
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "changingSettings")
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isSitter")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("tabBarControllerOwner") as UIViewController
        presentViewController(vc, animated: false, completion: nil)
    }
}