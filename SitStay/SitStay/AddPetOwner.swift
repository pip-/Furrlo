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
    
    @IBOutlet weak var petAge: UITextField!
    
    
    var name: String?
    var species: String?
    var breed: String?
    var stringAge: String?
    var personality: String?
    var food: String?
    var notes: String?
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                            if(breed.characters.count > 0){
                                if let stringAge = petAge.text{
                                    if(stringAge.characters.count > 0){
                                        if let personality = petPersonalityLabel.text{
                                            if(personality.characters.count > 0){
                                                if let food = petFoodLabel.text{
                                                    if(food.characters.count > 0){
                                                        if let notes = petNotes.text{
                                                            if(notes.characters.count > 0){
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
            }}
            let submitButton = self.navigationItem.rightBarButtonItems![0]
            submitButton.enabled = false
        }
    
    
    @IBAction func loadImage(sender: AnyObject) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func submitPet() {
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let user = appDelegate.getUser()
        let userID=user!.userID
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.petsitterz.netau.net/addPet.php")!)
        
        request.HTTPMethod = "POST"
        let postString = "a=\(petSpecies.text!)&b=\(petNameLabel.text!)&c=\(petAge.text!)&d=\(petBreedLabel.text!)&e=\(petPersonalityLabel.text!)&f=\(petNotes.text!)&g=\(userID!)&h=\(petFoodLabel.text!)"
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
       //////////////////////////////////////////////////////
            
            //////Gets All Pets from server with your UserID////////
            //////Adds ALL pets to pets////////
            //////Need to make it just one?/////
            
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
                
                print("response = \(response)")
                print("userID")
                print(userID!)
                
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
                   // print("PROOF!")
                    for dict in petDicts{
                        appDelegate.insertNewPet(dict["PetName"], species: dict["PetType"], breed: dict["PetBreed"], age: dict["PetAge"], personality: dict["PetPersonality"], food: dict["PetFood"], notes: dict["OtherNotes"])
                        print(String(dict["PetName"]))
                        print(String(dict["PetID"]))
                    }
                    //-------------------------------------------
                }

            
                
           
        }
        task.resume()

        }
 
        //cancel(self)
 
        navigationController?.popViewControllerAnimated(true)
    }
 
 

 
}
