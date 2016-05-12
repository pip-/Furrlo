//
//  TripTabSitterMain.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/7/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class TripTabSitterMain: UITableViewController {
    
    var reuseIdentifier = "tripCell"
    var noTripsReuseIdentifier = "noTripsCell"
    
    var tripNames: [String] = []
    var tripIds: [Int] = []
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let fetchedTrips = appDelegate.getTrips(){
            for trip in fetchedTrips{
                    if(trip.isSitting!.boolValue == true){
                        if(trip.endDate >= NSDate.init(timeIntervalSinceNow: 3600 * 24 * 2)){
                            print("Deleting a trip that is too old.")
                            appDelegate.deletePetsAndToDoItemsWithTripID(Int(trip.tripID!))
                            appDelegate.deleteTrip(Int(trip.tripID!))
                        }else{
                        tripNames.append(trip.tripName!)
                        tripIds.append(Int(trip.tripID!))
                            print("showing trip id")
                            print(trip.tripID)
                        
                        }
                }
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        if(tripNames.count > 0){
            self.navigationItem.rightBarButtonItem = self.editButtonItem()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        print("Will Appear...")
        tripNames.removeAll()
        tripIds.removeAll()
        if let fetchedTrips = appDelegate.getTrips(){
                for trip in fetchedTrips{
                    if(trip.isSitting!.boolValue == true){
                        tripNames.append(trip.tripName!)
                        tripIds.append(Int(trip.tripID!))
                        print(trip.tripName!)
                    }
            }
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
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //let editing = NSUserDefaults.standardUserDefaults().boolForKey("editing")
        if(tripNames.count == 0){
            return 2
        } else {
            return tripNames.count + 2
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(tripNames.count == 0){
            if(indexPath.row == 0){
                return 200
            }
        }
        return 50
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let editing = NSUserDefaults.standardUserDefaults().boolForKey("editing")
        if(tripNames.count == 0){
            if(indexPath.row == 0){
                let cell = tableView.dequeueReusableCellWithIdentifier(noTripsReuseIdentifier, forIndexPath: indexPath)
            
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("confirmTripCell", forIndexPath: indexPath)
                return cell
            }
        }
        else {
            if(indexPath.row < tripNames.count + 1){
                if(indexPath.row == 0){
                    let cell = tableView.dequeueReusableCellWithIdentifier("nextCell", forIndexPath: indexPath)
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! TripCell
                    // Configure the cell...
                    cell.changeLabel(tripNames[indexPath.row - 1])
                    cell.tripID = tripIds[indexPath.row - 1]
                    return cell
                }
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("confirmTripCell", forIndexPath: indexPath)
                return cell
            }
        }
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if(tripNames.count > 0){
            if(indexPath.row > 0 && indexPath.row <= tripNames.count){
                return true
            }
        }
        return false
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            if(appDelegate.deleteTrip(tripIds[indexPath.row - 1])){
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "editing")
                tripNames.removeAtIndex(indexPath.row - 1)
                tripIds.removeAtIndex(indexPath.row - 1)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "toViewTrip"){
            let vc = segue.destinationViewController as! ViewTripSitter
            let s = sender as! TripCell
            if let tripID = s.tripID{
                vc.trip = appDelegate.getTripWithID(tripID)
            }
        }
    }
    
    
}
