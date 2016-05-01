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
    
    @IBOutlet weak var imageView: UIImageView!
    
    var petName: String?
   
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        

        
        if let fetchedPets = appDelegate.getPets(){
            for pet in fetchedPets{
                if (pet.name == petName){
                    petNameLabel.text = petName
                    petAge.text = pet.age
                    petSpecies.text = pet.species
                    petBreedLabel.text = pet.breed
                    petPersonalityLabel.text = pet.personality
                    petFoodLabel.text = pet.food
                    petNotes.text = pet.notes
                   
                    if(pet.species == "Dog" || pet.species == "dog"){
                        imageView.image = UIImage(named: "dog profile.png")

                    }
                    else if(pet.species == "Cat" || pet.species == "cat"){
                        imageView.image = UIImage(named: "cat head.png")

                    }
                    else{
                        imageView.image = UIImage(named: "Untitled-6.png")                    }
                    
                 self.title = pet.name   
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
        
        
        
    }
 
    
}
