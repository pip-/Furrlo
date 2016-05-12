//
//  Owner_AddPet.swift
//  Pet_Tab
//
//  Created by MU IT Program on 3/30/16.
//  Copyright © 2016 Megan Cochran. All rights reserved.
//

import UIKit

class AddPetOwner: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    //@IBOutlet weak var petAge: UILabel!
    
    @IBOutlet weak var petSpecies: UITextField!
    @IBOutlet weak var petNotes: UITextField!
    @IBOutlet weak var petFoodLabel: UITextField!
    @IBOutlet weak var petPersonalityLabel: UITextField!
    @IBOutlet weak var petBreedLabel: UITextField!
    @IBOutlet weak var petNameLabel: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    //var petPicture: NSData?
    
    @IBOutlet weak var petAge: UITextField!
    
    
    var activeTextField: UITextField? = nil
    let keyboardVerticalSpacing: CGFloat = 30
    
    var testString: String?
    var name: String?
    var species: String?
    var breed: String?
    var stringAge: String?
    var personality: String?
    var food: String?
    var notes: String?
    

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSizeMake(self.view.frame.width, self.view.frame.height+100)

        
        self.title = "Add Pet"
        imagePicker.delegate = self
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        let submitButton = UIBarButtonItem(title: "Submit", style: .Plain, target: self, action: #selector(AddPetOwner.submitPet))
        
        
        
        self.navigationItem.rightBarButtonItems = [submitButton]
        
        submitButton.enabled = false
        
        petNameLabel.addTarget(self, action: #selector(AddPetOwner.checkIfCanSave(_:)), forControlEvents: UIControlEvents.EditingChanged)
        petBreedLabel.addTarget(self, action: #selector(AddPetOwner.checkIfCanSave(_:)), forControlEvents: UIControlEvents.EditingChanged)
        petSpecies.addTarget(self, action: #selector(AddPetOwner.checkIfCanSave(_:)), forControlEvents: UIControlEvents.EditingChanged)
        petAge.addTarget(self, action: #selector(AddPetOwner.checkIfCanSave(_:)), forControlEvents: UIControlEvents.EditingChanged)
        petPersonalityLabel.addTarget(self, action: #selector(AddPetOwner.checkIfCanSave(_:)), forControlEvents: UIControlEvents.EditingChanged)
        petFoodLabel.addTarget(self, action: #selector(AddPetOwner.checkIfCanSave(_:)), forControlEvents: UIControlEvents.EditingChanged)
        petNotes.addTarget(self, action: #selector(AddPetOwner.checkIfCanSave(_:)), forControlEvents: UIControlEvents.EditingChanged)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkIfCanSave(textfield: UITextField){
        if let name = petNameLabel.text{
            if(name.characters.count > 0){
                if let species = petSpecies.text{
                    if(species.characters.count > 0){
                        if let breed = petBreedLabel.text{
                            if(breed.characters.count >= 0){
                                if let stringAge = petAge.text{
                                    if(stringAge.characters.count >= 0){
                                        if let personality = petPersonalityLabel.text{
                                            if(personality.characters.count >= 0){
                                                if let food = petFoodLabel.text{
                                                    if(food.characters.count >= 0){
                                                        if let notes = petNotes.text{
                                                            if(notes.characters.count >= 0){
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
                            }
                        }
                    }
                }
            }
        }
            let submitButton = self.navigationItem.rightBarButtonItems![0]
            submitButton.enabled = false
        }
    
    
   /* @IBAction func loadImage(sender: AnyObject) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
            
           // let petPicture = UIImageJPEGRepresentation(pickedImage, 1.0)
            //imageData = UIImageJPEGRepresentation(pickedImage, 1)!
             //let petImage: UIImage = UIImage(data:imageData,scale:1.0)!
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }*/
    
    func textFieldDidBeginEditing(textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        activeTextField = nil
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        activeTextField?.resignFirstResponder()
        
        return true
    }
    
    
    func submitPet() {
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let user = appDelegate.getUser()
        let userID=user!.userID
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.petsitterz.netau.net/addPet.php")!)
        
        request.HTTPMethod = "POST"
        let postString = "a=\(petSpecies.text!)&b=\(petNameLabel.text!)&c=\(petAge.text!)&d=\(petBreedLabel.text!)&e=\(petPersonalityLabel.text!)&f=\(petNotes.text!)&g=\(userID!)&h=\(petFoodLabel.text!)"
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
            self.getPetAddPet()
        }
        task.resume()
        

       
    }
    
    //////Gets All Pets from server with your UserID////////
    //////Adds ALL pets to pets////////
    //////Need to make it just one?/////
    func getPetAddPet(){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let user = appDelegate.getUser()
        let userID=user!.userID
        testString=petNameLabel.text
        
        
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
                let petStrings: [String] = parsedJsonString.characters.split("&").map(String.init)
                //------------------------------------------
                
                //Parse each string into dictionary---------
                var petDicts: [[String: String]] = []
                for string in petStrings{
                    if let dict = string.convertToDictionary(){
                        petDicts.append(dict)
                    }
                }
                //-------------------------------------------
                
                //Prove that this works----------------------
                //print("PROOF!")
                //for dict in petDicts{
                
                //print(String(dict["PetName"]))
                //print(String(dict["PetID"]))}
                
                //let petInt = Int(dict["PetID"]!)
                //let petNS = NSNumber(integer: petInt!)
                
                
                print("Counting Array Length")
                print(petDicts.count)
                print("SHOWING FIRST")
                print(petDicts.first)
                print("SHOWING MOST RECENT")
                print(petDicts.last)
                
                
                
                // if(petDicts.count == 1){
                let myPetDict = petDicts.first
                print("PRINT FIRST PET 1")
                if let petID = Int(myPetDict!["PetID"]!){
                    print("PRINT FIRST PET 2")
                    appDelegate.insertNewPet(self.petNameLabel.text!, species: self.petSpecies.text!, breed: self.petBreedLabel.text!, age: self.petAge.text!, personality: self.petPersonalityLabel.text!, food: self.petFoodLabel.text!, notes: self.petNotes.text!, isSat: false, user: user!, petID: petID )
                    print("PRINT FIRST PET 3")
                    print(self.petNameLabel.text)
                }
                /*}
                 else{
                 if let myPetDict = petDicts.last{
                 print("PRINT LAST PET 1")
                 if let petID = Int(myPetDict["PetID"]!){
                 print("PRINT LAST PET 2")
                 appDelegate.insertNewPet(self.petNameLabel.text!, species: self.petSpecies.text!, breed: self.petBreedLabel.text!, age: self.petAge.text!, personality: self.petPersonalityLabel.text!, food: self.petFoodLabel.text!, notes: self.petNotes.text!, isSat: false, user: user!, petID: petID )
                 print("PRINT LAST PET 3")
                 print(self.petNameLabel.text)
                 }}
                 }*/
                
                
                print ("pet added")
                
                //}
                //-------------------------------------------
                
                self.taskComplete()
            }
        }
        
        task.resume()
        //cancel(self)
    }
    
    func taskComplete(){
        NSOperationQueue.mainQueue().addOperationWithBlock{
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
}
