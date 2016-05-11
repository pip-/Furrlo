//
//  Owner_ExistingPet.swift
//  Pet_Tab
//
//  Created by MU IT Program on 3/30/16.
//  Copyright © 2016 Megan Cochran. All rights reserved.
//

import UIKit

class ExistingPetOwner: UIViewController{
    
    @IBOutlet weak var petAge: UILabel!
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petSpecies: UILabel!
    @IBOutlet weak var petBreedLabel: UILabel!
    @IBOutlet weak var petPersonalityLabel: UILabel!
    @IBOutlet weak var petFoodLabel: UILabel!
    @IBOutlet weak var petNotes: UILabel!
    
    @IBOutlet weak var personailtyHeader: UILabel!
    @IBOutlet weak var foodHeader: UILabel!
    @IBOutlet weak var notesHeader: UILabel!
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var petName: String?
    var petID: Int?
   
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        

        
        if let fetchedPets = appDelegate.getPets(){
            for pet in fetchedPets{
                if (pet.petID == petID){
                    petNameLabel.text = pet.name
                    petAge.text = pet.age
                    petSpecies.text = pet.species
                    petBreedLabel.text = pet.breed
                    petPersonalityLabel.text = pet.personality
                    petFoodLabel.text = pet.food
                    petNotes.text = pet.notes
                    imageView.image = self.appDelegate.pickPetPicture(pet.species!)
                    
                    if(pet.personality?.characters.count == 0){
                        personailtyHeader.text = ""
                    }
                    if(pet.food?.characters.count == 0){
                        foodHeader.text = ""
                    }
                    if(pet.notes?.characters.count == 0){
                        notesHeader.text = ""
                    }
                    
                    
                 self.title = pet.name
                    print("hello world")
                    print(pet.petID!)
                    
                }
            
            }
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    @IBAction func deletePet(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Delete Pet", message: "Do you want to delete this pet?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {
            (alertAction) -> Void in
            // handle cancellation of deletion
            //self.deleteStatusLabel.text = "item deletion cancelled"
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Destructive, handler: {
            (alertAction) -> Void in
            // handle deletion here
            self.appDelegate.deletePet(self.petName!)
            self.navigationController?.popViewControllerAnimated(true)
            //self.deleteStatusLabel.text = "item deleted"
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
        
        let user = appDelegate.getUser()
        let userID=user!.userID
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.petsitterz.netau.net/removePet.php")!)
        
        request.HTTPMethod = "POST"
        let postString = "a=\(userID!)&b=\(self.petName!)"
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
    }
 
    
}
