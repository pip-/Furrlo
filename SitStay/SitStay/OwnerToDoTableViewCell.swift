//
//  OwnerToDoTableViewCell.swift
//  SitStay
//
//  Created by Michael Mclaughlin on 4/29/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class OwnerToDoTableViewController: UITableViewController{
    
    //@IBOutlet var OwnerLists: UITableView!
    @IBOutlet var OwnerLists: UITableView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var dailyTaskLists = [["Today Food","Today Water","Today Exercise"],["Tomorrow Food","Tomorrow Water","Tomorrow Exercise"],["Later Food","Later Water","Later Exercise"]]
    
     var dayTitles = ["Today","Tomorrow","Later"]
    
    //var dailyTaskLists: [String] = []
    //var dayTitles: [String] = []
    var toDoItems: [String] = []
    var toDoItemsDetails: [String] = []
    var pets: [String] = []
    
    var taskDone = true;
    
    //var pets : [String] = ["Mira"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OwnerLists.delegate = self
        OwnerLists.dataSource = self
        
        if let fetchedToDoItems = appDelegate.getToDoItems(){
            for toDoItem in fetchedToDoItems{
                toDoItems.append(toDoItem.instruction!)
                toDoItemsDetails.append(toDoItem.instructionDetail!)
                
            }
        }
        
        if let fetchedPets = appDelegate.getPets(){
            for pet in fetchedPets{
                pets.append(pet.name!)
            }
        }
        
    
        if(dailyTaskLists.count > 0){
            self.navigationItem.rightBarButtonItem = self.editButtonItem()
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        toDoItems.removeAll()
        pets.removeAll()
        
        if let fetchedToDoItems = appDelegate.getToDoItems(){
            for toDoItem in fetchedToDoItems{
                toDoItems.append(toDoItem.instruction!)
                toDoItemsDetails.append(toDoItem.instructionDetail!)
                
            }
        }
        if let fetchedPets = appDelegate.getPets(){
            for pet in fetchedPets{
                pets.append(pet.name!)
            }
        }
        
        if(dailyTaskLists.count > 0){
            self.navigationItem.rightBarButtonItem = self.editButtonItem()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //return dayTitles.count
        return pets.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dailyTaskLists[section].count
        //return toDoItems.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("dataCell",forIndexPath: indexPath)
        
        cell.textLabel?.text = dailyTaskLists[indexPath.section][indexPath.row]
        
        if (taskDone == true){
            cell.accessoryType = .Checkmark
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("headerCell") as! DayTableViewCell
        
        cell.textLabel?.text = pets[section]
        
        return cell
    }
    
 
    
    
    
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }

    
  //Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
    // Delete the row from the data source
        //if(appDelegate.deleteToDoTask(dailyTaskLists[indexPath.row - 1])){
        
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "editing")
            //dailyTaskLists.removeAtIndex(indexPath.row - 1)
        
            dailyTaskLists.removeAtIndex(indexPath.row - 1)
        
        
            //tripIds.removeAtIndex(indexPath.row - 1)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
     } //else if editingStyle == .Insert {
        //// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
       // }
    
    
    
    
    
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