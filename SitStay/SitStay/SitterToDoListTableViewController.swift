//
//  SitterToDoListTableViewController.swift
//  SitStay
//
//  Created by MU IT Program on 4/19/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class SitterToDoListTableViewController: UITableViewController {
    
    //call AppDelegate
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    
    //local variables to assign to ToDoItem variables
    var toDoItems: [String] = []
    var toDoItemsDetails: [String] = []
    var toDoItemsComplete: [Int] = []
    var itemPetIDs: [Int] = []
    var petisSat: [Int] = []
    
    var pets : [String] = []
    
    
    
    //Filler text for task list
    var dailyTaskLists = [["Today Food","Today Water","Today Exercise"],["Tomorrow Food","Tomorrow Water","Tomorrow Exercise"],["Later Food","Later Water","Later Exercise"]]
    
    //Filler text for task list subtitle
    var dailyTaskListDetails = [["test 1.1","test 1.2","test1.3"],["test 2.1","test 2.2","test2.3"]]
    
    //Filler text for daily titles
    //var dailyTitles = ["Today","Tomorrow","Later"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assign local variable to Pets variable
        if let fetchedPets = appDelegate.getPets(){
            for pet in fetchedPets{
                pets.append(pet.name!)
            }
            
        }
        
        
        //assign local variables to ToDoItem variables
        if let fetchedToDoItems = appDelegate.getToDoItems(){
            for toDoItem in fetchedToDoItems{
                //checks animals being displayed are being sat (not sitters own animals)
                if(toDoItem.isSat!.boolValue == true){
                    
                    toDoItems.append(toDoItem.instruction!)
                    toDoItemsDetails.append(toDoItem.instructionDetail!)
                    itemPetIDs.append((toDoItem.petID?.integerValue)!)
                    petisSat.append((toDoItem.isSat?.integerValue)!)
                
                    //print(toDoItem.instruction)
                    //print(toDoItem.instructionDetail)
                }
            
            }
            
        }
        
    
        
        
        /*if let fetchedToDoItems = appDelegate.getToDoItems(){
            for ToDoItem in fetchedToDoItems{
                if(ToDoItem.isSat?.boolValue == true)
                
            }
        }*/
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
            return pets.count
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(toDoItems)
        return toDoItems.count
        //return dailyTaskLists.count
        
    }

    //Configure "data cells" with task text
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("dataCell", forIndexPath: indexPath)

        cell.textLabel?.text = toDoItems[indexPath.row]
        
        cell.detailTextLabel?.text = toDoItemsDetails[indexPath.row]
        
        //cell.textLabel?.text = dailyTaskLists[indexPath.section][indexPath.row]
        //cell.detailTextLabel?.text = dailyTaskListDetails[indexPath.section][indexPath.row]
        
        //print(toDoItems[indexPath.section])
        //print(toDoItemsDetails[indexPath.row])
        //print("Break")
        
        return cell
    }
    
    //Configure "header cells" with title text
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("headerCell") as! SitterToDoListTableViewCell
        
        cell.textLabel?.text = pets[section]
        
        //print(pets)
        //print(pets.count)
        
        
        return cell
    }
    
    
    //Add mark as done functionality
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        // Create an option menu as an action sheet
        let alert = UIAlertController(title: nil, message: "Do you want to mark this item as done?", preferredStyle:.ActionSheet)
        
        // Add cancel actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        
        //Add mark as done action to the menu
        let markDone = UIAlertAction(title: "Mark as done", style: .Default, handler: {
            (action:UIAlertAction!) -> Void in
            
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell?.accessoryType = .Checkmark
            
            //add functionality to save task that have been marked as done
            //print("To do items complete",self.toDoItemsComplete)
            
            //self.appDelegate.setToDoItemComplete(petisSat, toDoItemID: itemPetIDs)
            
        })
        
        alert.addAction(markDone)
        
        //Add mark as not done action to the menu
        let markNotDone = UIAlertAction(title: "Mark as not done", style: .Default, handler: {
            (action:UIAlertAction!) -> Void in
            
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell?.accessoryType = .DisclosureIndicator
            
        })
        
        alert.addAction(markNotDone)
        
        
    
        // Display the menu
        self.presentViewController(alert, animated: true, completion: nil)
        
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
