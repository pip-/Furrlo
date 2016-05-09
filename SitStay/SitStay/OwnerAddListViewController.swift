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
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var complete: NSNumber?
    var instruction: String?
    var instructionDetail: String?
    var itemID: NSNumber?
    var petID: NSNumber?
    var isSat: NSNumber?
    var pets : [String] = []
    var petName: String?
    var testString: String?
    
    var petIDs: [Int] = []
    
    let keyboardVerticalSpacing: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pets.removeAll()
        
        if let fetchedPets = appDelegate.getPets(){
            for pet in fetchedPets{
                pets.append(pet.name!)
                petIDs.append(pet.petID!.integerValue)
                
            }
        }
        
        
        //Print petIds pulled from database
        print(petIDs)

        
        if (pets.count == 0){
            selectionLabel.text = "No pets"
        } else {
        pickerView.selectRow(2, inComponent: 0, animated: false)
        selectionLabel.text = pets[pickerView.selectedRowInComponent(0)]
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
        if(pets.count == 0)
        {
            return 1
        }else
        {
            return pets.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pets.count == 0)
        {
            return "No pets"
        } else {
            return pets[row]
        }
      //  return pets[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(pets.count == 0)
        {
        selectionLabel.text = "No pets"
        } else {
        selectionLabel.text = pets[row]
        }
    }
    
    @IBAction func taskSubmitted(sender: AnyObject) {
        checkSave()
        complete = 0;
        print(complete)
        let itemID = (arc4random_uniform(800000))
        print(itemID)
        let petID = petIDs
        print(petID)
        let PetName = selectionLabel.text
        print(PetName)
        let instruction = instructionField.text
        print(instruction)
        let instructionDetail = instructionDetailsField.text
        print(instructionDetail)
        submitTask(petIDs, petName: petName!, instruction: instruction!, instructionDetail: instructionDetail!)
        
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
 
 
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.petsitterz.netau.net/addTask.php")!)
        
        request.HTTPMethod = "POST"
        let postString = "a=\(petID)&b=\(petName)&c=\(instruction)&d=\(instructionDetail)"
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
       // getTaskAddTask()
        
    }
    
    func getTaskAddTask(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let user = appDelegate.getUser()
        let userID = user!.userID
        testString = selectionLabel.text
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.petsitterz.netau.net/getPetFromUserID.php")!)
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
                
                appDelegate.insertNewToDoItem(self.complete!, instruction: self.instruction!, instructionDetail: self.instructionDetail!, itemID: self.itemID!, petID: self.petID!, isSat: false)
                
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