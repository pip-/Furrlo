//
//  OwnerFinishedListViewController.swift
//  SitStay
//
//  Created by Michael Mclaughlin on 4/26/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class OwnerFinishedListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var tasks = [["Food","Water","Exercise"],["Food","Water"]]
    var time : [String] = ["8:00 Am","8:00 Am","10:00 AM"]
    var days : [String] = ["Today","Tomorrow"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
   func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return days.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks[section].count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("headercell") as! DayTableViewCell
        
        cell.textLabel?.text = days[section]
        
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        cell!.textLabel?.text = tasks[indexPath.section][indexPath.row]
        cell?.detailTextLabel?.text = time[indexPath.row]
        
        return cell!
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
