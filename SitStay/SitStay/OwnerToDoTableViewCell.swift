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
    
    //var dailyTaskLists = [["Today Food","Today Water","Today Exercise"],["Tomorrow Food","Tomorrow Water","Tomorrow Exercise"],["Later Food","Later Water","Later Exercise"]]
    
   //  var dayTitles = ["Today","Tomorrow","Later"]
    
    //var dailyTaskLists: [String] = []
    //var dayTitles: [String] = []
    var toDoItems: [String] = []
    var toDoItemsDetails: [String] = []
    var pets: [String] = []
    var itemPetIDs: [[Int]] = [[]]
    var complete: [NSNumber] = []
    var petIds: [NSNumber] = []
    var toDoItemTaskIds: [[Int]] = [[]]

    var taskDone = true;
    
    
    //var pets : [String] = ["Mira"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OwnerLists.delegate = self
        OwnerLists.dataSource = self

        print("View Did Load")
        
        var i = 0
        
         if let fetchedPets = appDelegate.getPets(){
            for pet in fetchedPets{
                //print("Fetched Pets in ViewDidLoad")
                pets.append(pet.name!)
                petIds.append(pet.petID!)
                itemPetIDs.append([])
                toDoItemTaskIds.append([])
                if let fetchedToDoItems = appDelegate.getToDoItems(){
                    for toDoItem in fetchedToDoItems{
                        if toDoItem.petID == pet.petID{
                            itemPetIDs[i].append((toDoItem.petID?.integerValue)!)
                            toDoItems.append(toDoItem.instruction!)
                            toDoItemsDetails.append(toDoItem.instructionDetail!)
                            complete.append(toDoItem.complete!)
                            toDoItemTaskIds[i].append((toDoItem.itemID?.integerValue)!)
                        }
                    }
                }
                i += 1
            }
        }
        
    
        
        /*
        if let fetchedToDoItems = appDelegate.getToDoItems(){
            print("called GetToDoItems in ViewDidLoad")
            for ToDoItem in fetchedToDoItems{
                print("Fetched To Do Items In ViewDidLoad")
                toDoItems.append(ToDoItem.instruction!)
                toDoItemsDetails.append(ToDoItem.instructionDetail!)
                itemPetIDs.append((ToDoItem.petID?.integerValue)!)
                complete.append(ToDoItem.complete!)
                //print(ToDoItem.instruction)
                //print(ToDoItem.instructionDetail)
                //print(ToDoItem.petID)
                //print(ToDoItem.complete!)
                
            }
        }
        
       */
        
    
        if(toDoItemTaskIds.count > 0){
            self.navigationItem.rightBarButtonItem = self.editButtonItem()
        }
    

    }
    
    override func viewWillAppear(animated: Bool) {
        toDoItems.removeAll()
        pets.removeAll()
        itemPetIDs.removeAll()
        toDoItemTaskIds.removeAll()
        toDoItemsDetails.removeAll()
        petIds.removeAll()
        
        print("View Will Appear")
        
        
        
        var i = 0
        
        if let fetchedPets = appDelegate.getPets(){
            for pet in fetchedPets{
                //print("Fetched Pets in ViewDidLoad")
                pets.append(pet.name!)
                petIds.append(pet.petID!)
                itemPetIDs.append([])
                toDoItemTaskIds.append([])
                if let fetchedToDoItems = appDelegate.getToDoItems(){
                    for toDoItem in fetchedToDoItems{
                        if toDoItem.petID == pet.petID{
                            itemPetIDs[i].append((toDoItem.petID?.integerValue)!)
                            toDoItems.append(toDoItem.instruction!)
                            toDoItemsDetails.append(toDoItem.instructionDetail!)
                            complete.append(toDoItem.complete!)
                            toDoItemTaskIds[i].append((toDoItem.itemID?.integerValue)!)
                        }
                    }
                }
                i += 1
            }
        }
        
        /*
        if let fetchedToDoItems = appDelegate.getToDoItems(){
            print("Called GetToDoItems in viewWillAppear")
            for ToDoItem in fetchedToDoItems{
                print("Fetched To Do Items in ViewWillAppear")
                toDoItems.append(ToDoItem.instruction!)
                toDoItemsDetails.append(ToDoItem.instructionDetail!)
                itemPetIDs.append((ToDoItem.petID?.integerValue)!)
                complete.append(ToDoItem.complete!)
                print(ToDoItem.instruction)
                print(ToDoItem.instructionDetail)
                print(ToDoItem.petID)
                //print(ToDoItem.complete!)
                
            }
        }
        if let fetchedPets = appDelegate.getPets(){
            for pet in fetchedPets{
                //print("Fetched Pets in ViewWillAppear")
                pets.append(pet.name!)
                petIds.append(pet.petID!)
                
            }
        }
        */
        
        
        if(toDoItemTaskIds.count > 0){
            self.navigationItem.rightBarButtonItem = self.editButtonItem()
        }
        
        self.tableView.reloadData()
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
        //return dailyTaskLists[section].count
        //let toDoItem = pets[section]
        
        //print(toDoItemTaskIds)
        //print(itemPetIDs)
        return toDoItemTaskIds[section].count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("dataCell",forIndexPath: indexPath)
    
        //print("itemPetIds")
        //print("itemPetIds at index path row")
        //print(itemPetIDs[indexPath.row])
        //print("petIds Section index path")
        //print(petIds[indexPath.section])
        //print(toDoItems[indexPath.row])
       
       var selectedID = itemPetIDs[indexPath.section][indexPath.row]
        var selectedTaskID = toDoItemTaskIds[indexPath.section][indexPath.row]
        //print("Selected ID")
        //print(selectedID)
        //var i = 0
        
       // print(toDoItems)
        //print("itemPetIds[i]")
        //print(itemPetIDs[i])
        //print(toDoItems[indexPath.row])
        //print("petIds Section index path")
        //print(petIds[indexPath.section])
       
        if let fetchedToDoItem = appDelegate.getItemWithID(selectedTaskID){
        
         cell.textLabel?.text = fetchedToDoItem.instruction
         cell.detailTextLabel?.text = fetchedToDoItem.instructionDetail
            
        //cell.textLabel?.text = toDoItems[indexPath.row]
        //cell.detailTextLabel?.text = toDoItemsDetails[indexPath.row]
      
            
        //i += 1
        if (fetchedToDoItem.complete! == 1){
            cell.accessoryType = .Checkmark
        }
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
     
    // Delete the row from the data source
        //if(appDelegate.deleteToDoTask(dailyTaskLists[indexPath.row - 1])){
        
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "editing")
        let selectedTaskID = toDoItemTaskIds[indexPath.section][indexPath.row]
           // appDelegate.deleteToDoItem(selectedTaskID)
        
        //toDoItems.removeAtIndex(indexPath.row)
        //toDoItemsDetails.removeAtIndex(indexPath.row)
        //complete.removeAtIndex(indexPath.row)
        
            //tripIds.removeAtIndex(indexPath.row - 1)
        
        

        if editingStyle == .Delete {
            // Delete the row from the data source
            if(appDelegate.deleteToDoItem(toDoItemTaskIds[indexPath.section][indexPath.row])){
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "editing")
                toDoItems.removeAtIndex(indexPath.row )
                //let itemID=toDoItemTaskIds[indexPath.row-1]
                toDoItemTaskIds[indexPath.section].removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
             viewWillAppear(true)
                
            }
                ///////DB Delete///////////
                /*
                let user = appDelegate.getUser()
                let userID=user!.userID
                
                
                let request = NSMutableURLRequest(URL: NSURL(string: "http://www.petsitterz.netau.net/removeTask.php")!)
                
                request.HTTPMethod = "POST"
                let postString = "a=\(userID!)&b=\(selectedTaskID)"
                //&i=\(imageView.image?)
                request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
                
                let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                    data, response, error in
                    
                    if error != nil {
                        print("error=\(error)")
                        return
                    }
                    
                    print("responseFromAddToDB = \(response)")
                    
                    let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("responseStringFromAddToDB = \(responseString)")
                    
                }
                task.resume()
*/
        }
    }
     //else if editingStyle == .Insert {
        //// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
       // }
    
    
    

    
    func getTaskAddTask(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let user = appDelegate.getUser()
        let userID = user!.userID
       // testString = selectionLabel.text
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.petsitterz.netau.net/getTask.php")!)
        request.HTTPMethod = "POST"
        let postString = "a=\(userID!)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("responseFromGetAdd = \(response)")
            print("userID")
            print(userID!)
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseStringFromGetAdd = \(responseString)")
            
            //Strip Escape Characters-------------------
            responseString = responseString?.stringByReplacingOccurrencesOfString("\n", withString: "")
            responseString = responseString?.stringByReplacingOccurrencesOfString("\r", withString: "")
            //------------------------------------------
            
            //Change to easier delimiters---------------
            responseString = responseString?.stringByReplacingOccurrencesOfString("},{", withString: "}&{")
            //------------------------------------------
            if let responseString = responseString{
                //Convert to String/Drop Garbage------------
                let s = String(responseString)
                var parsedJsonString = String(s.characters.dropLast(147))
                parsedJsonString = String(parsedJsonString.characters.dropFirst())
                //------------------------------------------
                
                
                //Put into array----------------------------
                let taskStrings: [String] = parsedJsonString.characters.split("&").map(String.init)
                //------------------------------------------
                
                //Parse each string into dictionary---------
                var taskDicts: [[String: String]] = []
                for string in taskStrings{
                    if let dict = string.convertToDictionary(){
                        taskDicts.append(dict)
                    }
                }
                //-------------------------------------------
                
                //Prove that this works----------------------
                // print("PROOF!")
                //for dict in petDicts{
                
                // print(String(dict["PetName"]))
                //print(String(dict["PetID"]))
                
                //appDelegate.insertNewToDoItem(complete!, instruction: self.instruction!, instructionDetail: self.instructionDetail!, itemID: self.itemID!, petID: self.petID!, isSat: false)
                
                // print ("pet added")
                //  }
                //-------------------------------------------
                
                //self.taskComplete()
            }
        }
        
        task.resume()
        //cancel(self)
        
    }

    
    
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