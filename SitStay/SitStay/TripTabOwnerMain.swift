//
//  TripTabOwnerMain.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/7/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class TripTabOwnerMain: UITableViewController {
    
    var reuseIdentifier = "tripCell"
    var noTripsReuseIdentifier = "noTripsCell"
    
    var tripNames: [String] = []
    var tripIds: [Int] = []
    var trips: [Trip] = []
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get()
        if let fetchedTrips = appDelegate.getTrips(){
            for trip in fetchedTrips{
                    if(trip.isSitting!.boolValue == false){
                        if(trip.endDate >= NSDate.init(timeIntervalSinceNow: NSTimeInterval.init(3600 * 24 * 2))){
                            print("Deleting a trip that is too old.")
                            //appDelegate.deletePetsAndToDoItemsWithTripID(Int(trip.tripID!))  //Don't delete owner's pets...
                            appDelegate.deleteTrip(Int(trip.tripID!))
                        } else {
                            tripNames.append(trip.tripName!)
                            tripIds.append(Int(trip.tripID!))
                            trips.append(trip)
                            print(trip.tripName!)
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
        tripNames.removeAll()
        tripIds.removeAll()
        //get()
        if let fetchedTrips = appDelegate.getTrips(){
            for trip in fetchedTrips{
                if(trip.isSitting!.boolValue == false){
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
        if(tripNames.count == 0){
            return 1
        } else {
            return tripNames.count + 1
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
        if(tripNames.count == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier(noTripsReuseIdentifier, forIndexPath: indexPath)
            
            return cell
        }
        else {
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
        }
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if(tripNames.count > 0){
            if(indexPath.row > 0){
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
                let tripID=tripIds[indexPath.row-1]
                tripIds.removeAtIndex(indexPath.row - 1)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                ///////DB Delete///////////
                
                let user = appDelegate.getUser()
                let userID=user!.userID
                
                
                let request = NSMutableURLRequest(URL: NSURL(string: "http://www.petsitterz.netau.net/removeTrip.php")!)
                
                request.HTTPMethod = "POST"
                let postString = "a=\(userID!)&b=\(tripID)"
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

                
                ///////////////////////////
            }
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    func get()
    {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let user = appDelegate.getUser()
        let userID=user!.userID
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.petsitterz.netau.net/getTripFromID.php")!)
        request.HTTPMethod = "POST"
        let postString = "a=\(userID!)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            
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
                let tripStrings: [String] = parsedJsonString.characters.split("&").map(String.init)
            //------------------------------------------
                
            //Parse each string into dictionary---------
                var tripDicts: [[String: String]] = []
                for string in tripStrings{
                    if let dict = string.convertToDictionary(){
                        tripDicts.append(dict)
                    }
                }
            //-------------------------------------------
                
            //Prove that this works----------------------
                print("PROOF!")
                for dict in tripDicts{
                    print(String(dict["tripName"]))
                    print(String(dict["TripID"]))
                    
                }
            //-------------------------------------------
        }
        }
        
        task.resume()
        
        
    }
    
    func rangeFromNSRange(nsRange: NSRange, forString str: String) -> Range<String.Index>? {
        let fromUTF16 = str.utf16.startIndex.advancedBy(nsRange.location, limit: str.utf16.endIndex)
        let toUTF16 = fromUTF16.advancedBy(nsRange.length, limit: str.utf16.endIndex)
        
        
        if let from = String.Index(fromUTF16, within: str),
            let to = String.Index(toUTF16, within: str) {
            return from ..< to
        }
        
        return nil
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
            let vc = segue.destinationViewController as! ViewTripOwner
            let s = sender as! TripCell
            if let tripID = s.tripID{
                vc.trip = appDelegate.getTripWithID(tripID)
            }
        }
    }
    
 

}
