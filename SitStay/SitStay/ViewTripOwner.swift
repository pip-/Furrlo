//
//  ViewTripOwner.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/17/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class ViewTripOwner: UITableViewController {
    
    var trip: Trip? = nil
    
    var content = ["March 4 - March 12", "4910 Smith Street, Columbia, Missouri 65203", "", "Example"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let b = UIBarButtonItem(
            title: "Edit",
            style: .Plain,
            target: self,
            action: #selector(ViewTripOwner.edit)
        )
        
        if let trip = trip{
            if let set = trip.pets{
                for pet in set.allObjects as! [Pet]{
                    content[2] += ", " + pet.name!
                }
            }
        }
        
        self.navigationItem.rightBarButtonItems = [b]
        
        self.title = content[3]
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section == 0){
            return 2
        } else {
            return 1
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section == 1){
            let cell = tableView.dequeueReusableCellWithIdentifier("mapCell", forIndexPath: indexPath)
            return cell
        }
        if(indexPath.section == 3){
            let cell = tableView.dequeueReusableCellWithIdentifier("inviteCell",forIndexPath: indexPath)
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("simpleCell", forIndexPath: indexPath) as! SimpleCell
        if(indexPath.section == 0){
            if(indexPath.row == 0){
                cell.changeTitle("Dates")
                cell.changeDetail(content[0])
            } else {
                cell.changeTitle("Address")
                cell.changeDetail(content[1])
                
            }
        }
        if(indexPath.section == 2){
            cell.changeTitle("To Do Lists")
            cell.changeDetail(content[2])
        }
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == 0){
            if(indexPath.row == 1){
                return 80
            }
        }
        if(indexPath.section == 1){
            return 100
        }
        return 60
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func edit(){
        print("Editing")
        let nc = self.navigationController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("editTrip")
        nc?.pushViewController(vc, animated: true)
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}