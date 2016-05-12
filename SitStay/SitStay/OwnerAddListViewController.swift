//
//  OwnerAddListViewController.swift
//  SitStay
//
//  Created by Michael Mclaughlin on 4/29/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class OwnerAddListViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var selectionLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var instructionField: UITextField!
    @IBOutlet weak var instructionDetailsField: UITextField!
    

    @IBOutlet weak var pickerView2: UIPickerView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var selectedTripID: Int = 0
    
    var complete: NSNumber?
    var instruction: String?
    var instructionDetail: String?
    var itemID: NSNumber?
    var petID: NSNumber?
    var isSat: NSNumber?
    var pets : [String] = []
    var petName: String?
    var testString: String?
    var selectedID: Int = 0
    
    var petIDs: [Int] = []
    var tripIDs: [Int] = []
    var tripNames: [String] = []
    
    let keyboardVerticalSpacing: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        

        pets.removeAll()
        
        if let fetchedPets = appDelegate.getPets(){
            for pet in fetchedPets{
                pets.append(pet.name!)
                petIDs.append(pet.petID!.integerValue)
                
            }
        }
        
        if let fetchedTrips = appDelegate.getTrips(){
            for trip in fetchedTrips{
                tripIDs.append(Int(trip.tripID!))
                tripNames.append(trip.tripName!)
                
            }
        }
        
        
        //Print petIds pulled from database
        print(petIDs)

        
        if (pets.count == 0){
            selectionLabel.text = "No pets"
        } else {
        pickerView.selectRow(2, inComponent: 0, animated: false)
        selectionLabel.text = pets[pickerView.selectedRowInComponent(0)]
        petID = petIDs[pickerView.selectedRowInComponent(0)]
          print(petID)
            selectedID = (petID?.integerValue)!
        }
        
        
        submitButton.enabled = false
        
        
        instructionField.addTarget(self, action: #selector(self.checkSave), forControlEvents: UIControlEvents.EditingChanged)
        
        instructionDetailsField.addTarget(self, action: #selector(OwnerAddListViewController.checkSave), forControlEvents: UIControlEvents.EditingChanged)
        
        self.hideKeyboardWhenTappedAround()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.pickerView{
        if(pets.count == 0)
        {
            return 1
        }else
        {
            return pets.count
        }
        } else {
            if(tripNames.count == 0)
            {
                return 1
            } else {
                return tripNames.count
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.pickerView{
        if (pets.count == 0)
        {
            return "No pets"
        } else {
            return pets[row]
        }
        } else {
            if pets.count == 0 {
                return "Not trips"
            } else {
                return tripNames[row]
            }
        }
      //  return pets[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.pickerView{
        if(pets.count == 0)
        {
        selectionLabel.text = "No pets"
        } else {
        selectionLabel.text = pets[row]
        let petID = petIDs[row]
        print(petID)
        selectedID = petID
        }
        } else {
            if(tripNames.count == 0){
                selectedTripID = 0
            } else {
                selectedTripID = tripIDs[row]
            }
        }
        
        
    }
    
    @IBAction func taskSubmitted(sender: AnyObject) {
        checkSave()
        complete = 0;
        //print(complete)
        //let itemID = (arc4random_uniform(800000))
        //print(itemID)
        
        //Gotta Get PetID From server..... figure it out bro
        //let petID
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let user = appDelegate.getUser()
        let userID = user!.userID
        
        
        let PetName = selectionLabel.text
        //print(PetName!)
        //let petID = appDelegate.getPetIDwithPetName(petName,userID: userID)
       // print((petID?.integerValue)!)
        //print("selectedID")
        //print(selectedID)
        let instruction = instructionField.text
        print(instruction!)
        let instructionDetail = instructionDetailsField.text
        print(instructionDetail!)
       // appDelegate.insertNewToDoItem(0, instruction: instruction!, instructionDetail: instructionDetail!, petID: selectedID, isSat: false)
        submitTask(selectedID, petName: PetName!, instruction: instruction!, instructionDetail: instructionDetail!)
       
        
    }
    
    func checkSave()
    {
        if let petName = selectionLabel.text{
            //print(petName)
            if(petName.characters.count > 0){
                //print(instruction)
                if let instruction = instructionField.text{
                    if(instruction.characters.count > 0)
                    {
                        if self.tripIDs.count > 0{
                        //print(instructionDetail)
                        if let instructionDetail = instructionDetailsField.text{
                            if(instructionDetail.characters.count > 0){
                                submitButton.enabled = true
                                return
                            }
                        }
                        }
                    }
                }
            }
        }
        submitButton.enabled = false
    }
        
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(OwnerAddListViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
 
    
    
    

    
    func submitTask( petID: Int, petName: String, instruction:  String, instructionDetail: String){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let user = appDelegate.getUser()
        let userID = user!.userID
 
        
        print("Looking for request")
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.petsitterz.netau.net/addTaskreturn.php")!)
        
        
        request.HTTPMethod = "POST"
        let postString = "a=\(petID)&b=\(petName)&c=\(instruction)&d=\(instructionDetail)&e=\(selectedTripID)"
        //&i=\(imageView.image?)
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("responseFromAddToDB = \(response)")
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseStringFromAddToDB = \(responseString)")
            
            //Strip Escape Characters-------------------
            responseString = responseString?.stringByReplacingOccurrencesOfString("\n", withString: "")
            responseString = responseString?.stringByReplacingOccurrencesOfString("\r", withString: "")
            //------------------------------------------
            
            //Change to easier delimiters---------------
            responseString = responseString?.stringByReplacingOccurrencesOfString("},{", withString: "}&{")
            //------------------------------------------
            if let responseString = responseString{
                let s = String(responseString)
                
                //Remove beginning stuff--------------------
                let junkSeparator: [String] = s.characters.split(";").map(String.init)
                let jsonStuff = junkSeparator[1]
                //------------------------------------------
                
                //Convert to String/Drop Garbage------------
                //let s = String(responseString)
                var parsedJsonString = String(jsonStuff.characters.dropLast(147))
                parsedJsonString = String(parsedJsonString.characters.dropFirst())
                //------------------------------------------
                
                
                //Put into array----------------------------
                let itemStrings: [String] = parsedJsonString.characters.split("&").map(String.init)
                //------------------------------------------
                
                //Parse each string into dictionary---------
                var itemDicts: [[String: String]] = []
                for string in itemStrings{
                    if let dict = string.convertToDictionary(){
                        itemDicts.append(dict)
                    }
                }
                //-------------------------------------------
                
                //Prove that this works----------------------
                print("PROOF!")
                let dict = itemDicts.last
                //print(String(dict["tripName"]))
                print("ITEM ID YO: "+String(dict!["TaskID"]))
                var selectedItemID = (dict!["TaskID"])
                let myInt: Int? = Int(selectedItemID!)
                
                appDelegate.insertNewToDoItem(0, instruction: instruction, instructionDetail: instructionDetail, petID: self.selectedID, isSat: false, taskID: myInt)
                
                self.taskComplete()
        
        }
        }

        
        task.resume()
        //self.taskComplete()
       // getTaskAddTask()
        
    }
    
    func getTaskAddTask(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let user = appDelegate.getUser()
        let userID = user!.userID
        //testString = selectionLabel.text
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.petsitterz.netau.net/getTaskOwner.php")!)
        request.HTTPMethod = "POST"
        let postString = "a=\(userID!),b=\(selectedID),c=\(instruction!)"
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
                
                //appDelegate.insertNewToDoItem(self.complete!, instruction: self.instruction!, instructionDetail: self.instructionDetail!, itemID: self.itemID!, petID: self.petID!, isSat: false)
                
                // print ("pet added")
                //  }
                //-------------------------------------------
                
                self.taskComplete()
            }
        }
        
        task.resume()
        //cancel(self)
 
    }
    
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
    
    
    
         func taskComplete(){
         NSOperationQueue.mainQueue().addOperationWithBlock{
         self.navigationController?.popViewControllerAnimated(true)
         }
         
         }

    
 }