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
        appDelegate.deletePet(petName!)
        navigationController?.popViewControllerAnimated(true)
        
        
    }
 
    
}
