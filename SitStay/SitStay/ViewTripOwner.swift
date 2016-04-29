//
//  ViewTripOwner.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/17/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit
import MapKit
import MessageUI

class ViewTripOwner: UITableViewController {
    
    var trip: Trip? = nil
    
    var content = ["", "", "", "Example"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let b = UIBarButtonItem(
            title: "Edit",
            style: .Plain,
            target: self,
            action: #selector(ViewTripOwner.edit)
            
        )
      
        content[0] = dateToString((trip?.startDate)!)
        content[0] += " - "
        content[0] += dateToString((trip?.startDate)!)
        
        content[1] = (trip?.addr1)!
        if let addr2 = trip?.addr2{
            if(addr2 != ""){
                content[1] += ", " + addr2
            }
        }
        content[1] += ", " + (trip?.city)!
        content[1] += ", " + (trip?.zip)!
        
        if let trip = trip{
            if let set = trip.pets{
                for pet in set.allObjects as! [Pet]{
                    if(content[2] != ""){
                        content[2] += ", " + pet.name!
                    } else {
                        content[2] = pet.name!
                    }
                }
            }
        }
        
        self.navigationItem.rightBarButtonItems = [b]
        
        content[3] = (trip?.tripName)!
        self.title = content[3]
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func dateToString(date: NSDate) -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy hh:mm"
        return dateFormatter.stringFromDate(date)
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
            let cell = tableView.dequeueReusableCellWithIdentifier("mapCell", forIndexPath: indexPath) as! MapCell
            cell.city = trip?.city
            cell.add1 = trip?.addr1
            cell.zip = trip?.zip
            cell.updateLocation()
            return cell
        }
        if(indexPath.section == 3){
            let cell = tableView.dequeueReusableCellWithIdentifier("inviteCell",forIndexPath: indexPath) as! InviteSitterCell
            cell.setParentController(self)
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
        let nc = self.navigationController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("editTrip") as! NewTripOwnerController
        vc.street = trip?.addr1
        vc.address2 = trip?.addr2
        vc.startDate = (trip?.startDate)!
        vc.endDate = (trip?.endDate)!
        vc.city = trip?.city
        vc.zip = trip?.zip
        vc.tripName = trip?.tripName
        vc.tripID = Int((trip?.tripID)!)
        
        if let trip = trip{
            if let set = trip.pets{
                for pet in set.allObjects as! [Pet]{
                    vc.chosenPets.append(pet)
                }
            }
        }
        nc?.pushViewController(vc, animated: true)
    }
    
    
    func get()
    {   let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let user = appDelegate.getUser()
        let userID=user!.userID
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.petsitterz.netau.net/getTripFromID.php")!)
        request.HTTPMethod = "POST"
        let postString = "a=\(userID!)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            print("userID")
            print(userID!)
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            
        }
        task.resume()
        
        
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