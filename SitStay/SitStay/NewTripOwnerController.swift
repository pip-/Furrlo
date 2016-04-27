//
//  NewTripOwnerController.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/14/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit
import MapKit

class NewTripOwnerController: UITableViewController {
    
    var datePickerSelected: Bool = false
    var rowSelected: Int = -1
    var startDate: NSDate = NSDate()
    var endDate: NSDate = NSDate(timeIntervalSinceNow: 900)
    var street: String?
    var address2: String?
    var zip: String?
    var city: String?
    var pets: [Pet] = []
    var chosenPets: [Pet] = []
    var tripName: String?
    var tripID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if let fetchedPets = appDelegate.getPets(){
            //print("Tried to fetch pets!")
            pets = fetchedPets
            print("# of pets: " + String(pets.count))
        }
        
        let submitButton = UIBarButtonItem(title: "Submit", style: .Plain, target: self, action: #selector(NewTripOwnerController.submit))
        
        submitButton.enabled = false
        
        self.navigationItem.rightBarButtonItems = [submitButton]
        
        self.navigationItem.title = "New Trip"
    }

    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 1){
            return 3
        }
        else if(section == 2){
            return 5
        }
        else if(section == 3){
            if(pets.count == 0){
                return 1
            } else {
                return pets.count
            }
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == 1){
            if(indexPath.row == 1){
                if(datePickerSelected){
                    return 100
                } else {
                    return 0
                }
            }
        }
        if(indexPath.section == 2){
            if(indexPath.row == 4){
                return 200
            }
        }
        
        if(indexPath.section == 3){
            if(pets.count == 0){
                return 50
            }
        }
        
        return 50
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 2){
            return 70
        }
        else {
            return 40
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
        let label = UILabel(frame: CGRectMake(22, 15, tableView.frame.size.width, 18))
        label.font = UIFont.systemFontOfSize(20)
        label.text = ""
        label.textColor = UIColor.init(colorLiteralRed: 13/255, green: 155/255, blue: 141/255, alpha: 1.0)
        view.addSubview(label)
        view.backgroundColor = UIColor.init(red: 238, green: 255, blue: 247, alpha: 0)
        
        if(section == 1){
            label.text = "Dates"
        }
        else if(section == 2){
            view.frame = CGRectMake(0, 0, tableView.frame.size.width, 70)
            label.text = "Address"
            label.frame = CGRectMake(22, 0, tableView.frame.size.width, 15)
            let label2 = UILabel(frame: CGRectMake(22, 25, tableView.frame.size.width, 16))
            label2.font = UIFont.systemFontOfSize(15)
            label2.textColor = UIColor.init(colorLiteralRed: 194/255, green: 201/255, blue: 198/244, alpha: 1.0)
            label2.text = "Where is the sitter taking care of your pet?"
            view.addSubview(label2)
        }
        else if(section == 3){
            label.text = "Which Pets will be watched?"
        } else if(section == 0){
            label.text = "Please Choose a Trip Name"
        }
        
        return view
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(indexPath.section == 1){
            if(indexPath.row == 0){
                let cell = tableView.dequeueReusableCellWithIdentifier("startDate", forIndexPath: indexPath) as! SimpleCell
                cell.changeDetail(dateToString(startDate))
                return cell
            }
            else if(indexPath.row == 1){
                let cell = tableView.dequeueReusableCellWithIdentifier("calendar", forIndexPath: indexPath) as! DatePickerCell
                cell.setPTVController(self)
                return cell
            }
            else if(indexPath.row == 2){
                let cell = tableView.dequeueReusableCellWithIdentifier("endDate", forIndexPath: indexPath) as! SimpleCell
                cell.changeDetail(dateToString(endDate))
                return cell
            }
            else {
                //let cell = tableView.dequeueReusableCellWithIdentifier("separator", forIndexPath: indexPath)
                //return cell
            }
        }
        else if(indexPath.section == 2){
            if(indexPath.row == 4){
                let cell = tableView.dequeueReusableCellWithIdentifier("mapCell", forIndexPath: indexPath) as! MapCell
                if let add1 = street{
                    cell.add1 = add1
                }
                if let zip = zip{
                    cell.zip = zip
                    
                }
                if let city = city{
                    cell.city = city
                }
                cell.updateLocation()
                return cell
            } else{
                let cell = tableView.dequeueReusableCellWithIdentifier("dateEntryCell", forIndexPath: indexPath) as! DateEntryCell
                
                if(indexPath.row == 0){
                    //print("Section")
                    cell.textField.placeholder = "Address Line 1"
                    cell.setPTVController(self, type: "street")
                    return cell
                }
                if(indexPath.row == 1){
                    cell.textField.placeholder = "Address Line 2"
                    cell.setPTVController(self, type: "address2")
                    return cell
                }
                if(indexPath.row == 2){
                    cell.textField.placeholder = "Zip Code"
                    cell.setPTVController(self, type: "zip")
                    return cell
                }
                if(indexPath.row == 3){
                    cell.textField.placeholder = "City"
                    cell.setPTVController(self, type: "city")
                    return cell
                }
            }
        } else if(indexPath.section == 3){
        if(pets.count == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier("noPetsCell", forIndexPath: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("petCheckCell", forIndexPath: indexPath) as! PetCheckCell
            
            cell.setPTVController(self, associatedPet: pets[indexPath.row])
            return cell
            }
        }
            let cell = tableView.dequeueReusableCellWithIdentifier("tripNameCell", forIndexPath: indexPath) as! TripNameCell
            cell.textField.placeholder = "Trip Name"
            cell.setPTVController(self, type: "tripName")
            return cell
        
    }
    
    enum UIModalTransitionStyle : Int {
        case CoverVertical = 0
        case FlipHorizontal
        case CrossDissolve
        case PartialCurl
    }
 
    @IBAction func cancel(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("tabBarControllerOwner") as! UITabBarController
        vc.selectedIndex = 0
        vc.modalTransitionStyle = .CrossDissolve
        presentViewController(vc, animated: true, completion: nil)
    }
    
    enum UITableViewRowAnimation : Int {
        case Fade
        case Right
        case Left
        case Top
        case Bottom
        case None
        case Middle
        case Automatic
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 0){
            datePickerSelected = true
            if(indexPath.row != 1){
                rowSelected=indexPath.row
            }
        } else{
            datePickerSelected = false
            rowSelected = -1
        }
        self.tableView.reloadSections(NSIndexSet.init(index: 0), withRowAnimation: .Middle)
    }
    
    func dateToString(date: NSDate) -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy hh:mm"
        return dateFormatter.stringFromDate(date)
    }
    
    func checkIfCanSubmit(){
        if let street = street{
            if(street.characters.count > 0){
                if let city = city{
                    if(city.characters.count > 0){
                        if let zip = zip{
                            if(zip.characters.count == 5 && checkZip(zip)){
                                if (chosenPets.count > 0){
                                    if let tripName = tripName{
                                        let submitButton = self.navigationItem.rightBarButtonItems![0]
                                        submitButton.enabled = true
                                        return
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        let submitButton = self.navigationItem.rightBarButtonItems![0]
        submitButton.enabled = false
    }
    
    func submit(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if let tripID = self.tripID{
            appDelegate.deleteTrip(tripID)
            appDelegate.saveContext()
        }
        let user = appDelegate.getUser()
        let userID=user!.userID
        
/*DB code below*/
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.petsitterz.netau.net/addTrip.php")!)
        
        request.HTTPMethod = "POST"
        if let address2 = address2{
            print("ADDRESS 2:" + address2)
            let address = street! + ", " + address2
        let postString = "a=\(userID!)&d=\(street!)&e=\(address2)&f=\(zip!)&g=\(city!)&b=\(startDate)&c=\(endDate)&h=\(tripName!)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            
        }
        task.resume()
        } else {
            let postString = "a=\(userID!)&d=\(street!)&f=\(zip!)&g=\(city!)&b=\(startDate)&c=\(endDate)&h=\(tripName!)"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                if error != nil {
                    print("error=\(error)")
                    return
                }
                
                print("response = \(response)")
                
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("responseString = \(responseString)")
                
            }
            task.resume()
        }
/*DB code Above*/
        appDelegate.insertNewTrip(startDate, endDate: endDate, street: street!, zip: zip!, city: city!, addr2: address2, pets: chosenPets, tripName: tripName!, isSitting: false)
        
        cancel(self)
    }
    
    func checkZip(str: String) -> Bool{
        if let num = Int(str) {
            return true
        }
        else {
            return false
        }
    }
    
    
    
    
/*    override func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 0){
            if(indexPath.row == 0 || indexPath.row == 2){
                print("Deselected row")
                datePickerSelected = false
                self.tableView.reloadSections(NSIndexSet.init(index: 0), withRowAnimation: .Middle)
            }
        }
    }*/

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
