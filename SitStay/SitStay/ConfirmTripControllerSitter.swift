//
//  ConfirmTripControllerSitter.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/25/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class ConfirmTripControllerSitter: UIViewController, UITextFieldDelegate {

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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        submit(self)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textFieldShouldReturn(textField)
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
                for dict in tripDicts{
                    if let startDate =
                        dict["TripStartDate"]?.toDateTime() {
                        if let endDate = dict["TripEndDate"]?.toDateTime(){
        
                            if let address2 = dict["UserAddress2"] {
                                if let phone = dict["userPhone"] {
                                    if let email = dict["userEmail"]{
                                        
                                        //APE
                                        self.appDelegate.insertNewTrip(startDate, endDate: endDate, street: dict["UserAddress"]!, zip: dict["Zipcode"]!, city: dict["City"]!, addr2: address2, pets: [], tripName: dict["tripName"]!, isSitting: true, phone: phone, email: email)
                                    } else{
                                        
                                        //APe
                                        self.appDelegate.insertNewTrip(startDate, endDate: endDate, street: dict["UserAddress"]!, zip: dict["Zipcode"]!, city: dict["City"]!, addr2: address2, pets: [], tripName: dict["tripName"]!, isSitting: true, phone: phone, email: nil)
                                    }
                                }
                                else {
                                    if let email = dict["userEmail"]{
                                        
                                        //ApE
                                        self.appDelegate.insertNewTrip(startDate, endDate: endDate, street: dict["UserAddress"]!, zip: dict["Zipcode"]!, city: dict["City"]!, addr2: address2, pets: [], tripName: dict["tripName"]!, isSitting: true, phone: nil, email: email)
                                    } else {
                                        
                                        //Ape
                                        self.appDelegate.insertNewTrip(startDate, endDate: endDate, street: dict["UserAddress"]!, zip: dict["Zipcode"]!, city: dict["City"]!, addr2: address2, pets: [], tripName: dict["tripName"]!, isSitting: true, phone: nil, email: nil)
                                    }
                                }
                            } else {
                                if let phone = dict["userPhone"] {
                                    if let email = dict["userEmail"] {
                                        
                                        //aPE
                                        self.appDelegate.insertNewTrip(startDate, endDate: endDate, street: dict["UserAddress"]!, zip: dict["Zipcode"]!, city: dict["City"]!, addr2: nil, pets: [], tripName: dict["tripName"]!, isSitting: true, phone: phone, email: email)
                                    } else {
                                        
                                        //aPe
                                        self.appDelegate.insertNewTrip(startDate, endDate: endDate, street: dict["UserAddress"]!, zip: dict["Zipcode"]!, city: dict["City"]!, addr2: nil, pets: [], tripName: dict["tripName"]!, isSitting: true, phone: phone, email: nil)
                                    }
                                } else {
                                    
                                    //apE
                                    if let email = dict["userEmail"]{
                                        self.appDelegate.insertNewTrip(startDate, endDate: endDate, street: dict["UserAddress"]!, zip: dict["Zipcode"]!, city: dict["City"]!, addr2: nil, pets: [], tripName: dict["tripName"]!, isSitting: true, phone: nil, email: email)
                                    } else {
                                        
                                        //ape
                                        self.appDelegate.insertNewTrip(startDate, endDate: endDate, street: dict["UserAddress"]!, zip: dict["Zipcode"]!, city: dict["City"]!, addr2: nil, pets: [], tripName: dict["tripName"]!, isSitting: true, phone: nil, email: nil)
                                    }
                                }
                            
                            }
                        }
                        else {
                            print("Wrong format")
                        }
                            
                    }
                //-------------------------------------------
            }
            }
            
            self.appDelegate.insertNewPet("Bob", species: "Dog", breed: "Lab", age: "11", personality: "loud", food: "dog food", notes: "he barks a lot", isSat: true)
            self.appDelegate.insertNewPet("Steve", species: "Cat", breed: "Spots", age: nil, personality: "", food: nil, notes: nil, isSat: true)
            self.appDelegate.insertNewPet("Jim", species: "Dog", breed: "Lab", age: "11", personality: "loud", food: "dog food", notes: "he barks a lot", isSat: true)

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