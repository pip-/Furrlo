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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

 
    
}
