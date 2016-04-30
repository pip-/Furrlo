//
//  ConfirmTripControllerSitter.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/25/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class ConfirmTripControllerSitter: UIViewController {

    @IBOutlet weak var textField: UITextField!
    var values:NSArray = []
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submit(sender: AnyObject) {
        
        //ToDo, pull trip object where trip.tripID = textField.text and all associated pets and to-do lists
        //let fetchedPets = appDelegate.getPets()
        
        //
        if let text = textField.text{
            if (text.characters.count > 0){
                get()
        }
        }
        
        
    }
    
    func get(){
        let tripID:Int? = Int(textField.text!)
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.petsitterz.netau.net/getTrip.php")!)
        request.HTTPMethod = "POST"
        let postString = "a=\(tripID!)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
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
                
                //Insert the new trip----------------------
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                for dict in tripDicts{
                    print(dict)
                    if let startDate =
                        dict["TripStartDate"]?.toDateTime() {
                        if let endDate = dict["TripEndDate"]?.toDateTime(){
                    if let addr2 = dict["UserAddress2"]{
                        self.appDelegate.insertNewTrip(startDate, endDate: endDate, street: dict["UserAddress"]!, zip: dict["Zipcode"]!, city: dict["City"]!, addr2: addr2, pets: [], tripName: dict["tripName"]!, isSitting: true)
                    }
                    else {
                        self.appDelegate.insertNewTrip(startDate, endDate: endDate, street: dict["UserAddress"]!, zip: dict["Zipcode"]!, city: dict["City"]!, addr2: nil, pets: [], tripName: dict["tripName"]!, isSitting: true)
                    }
                        }
                    } else {
                        print("Wrong format")
                    }
                }
                //-------------------------------------------
            }

            self.taskComplete()
        }
        task.resume()

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */



func taskComplete(){
    let storyboard = UIStoryboard(name: "Sitter", bundle: nil)
    let vc = storyboard.instantiateViewControllerWithIdentifier("tabBarControllerSitter") as! UITabBarController
    vc.selectedIndex = 0
    vc.modalTransitionStyle = .CrossDissolve
    let vc2 = storyboard.instantiateViewControllerWithIdentifier("tripTabSitterMain") as! TripTabSitterMain
    vc2.viewDidLoad()
    vc2.viewWillAppear(true)
    
    NSOperationQueue.mainQueue().addOperationWithBlock{
        self.presentViewController(vc, animated: true, completion: nil)
    }
}
}