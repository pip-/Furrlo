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
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
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
        
        
       
        
        saveButton.enabled = false
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkIfCanSave(){
        if let name = petNameLabel.text where !name.isEmpty{
            if let species = petSpecies.text where !species.isEmpty{
                if let breed = petBreedLabel.text where !breed.isEmpty{
                    if let personality = petPersonalityLabel.text where !personality.isEmpty{
                        if let food = petFoodLabel.text where !food.isEmpty{
                            if let notes = petNotes.text where !notes.isEmpty{
                                if let stringAge = petAge.text where !stringAge.isEmpty
                                {
                                    saveButton.enabled = true
                                    return
                                }
                            }
                        }
                    }
                }
            }
        }

      saveButton.enabled = false
    }


    @IBAction func savePet(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let user = appDelegate.getUser()
        let userID=user!.userID

        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.petsitterz.netau.net/addPet.php")!)
        
        request.HTTPMethod = "POST"
        let postString = "a=\(petSpecies.text!)&b=\(petNameLabel.text!)&c=\(petAge.text!)&d=\(petBreedLabel.text!)&e=\(petPersonalityLabel.text!)&f=\(petNotes.text!)&g=\(userID!)"
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
        
       
        
        
        appDelegate.insertNewPet(name!, species: species, breed: breed, age: stringAge, personality: personality, food: food, notes: notes)
        
        
        //cancel(self)

        navigationController?.popViewControllerAnimated(true)
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
    
    
}
