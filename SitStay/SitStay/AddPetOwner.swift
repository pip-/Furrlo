//
//  Owner_AddPet.swift
//  Pet_Tab
//
//  Created by MU IT Program on 3/30/16.
//  Copyright © 2016 Megan Cochran. All rights reserved.
//

import UIKit

class AddPetOwner: UIViewController {

    @IBOutlet weak var petAge: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add Pet"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func savePet(sender: AnyObject) {
        
        //will need to add how to save pet info here
        navigationController?.popViewControllerAnimated(true)
    }
    
    
}
