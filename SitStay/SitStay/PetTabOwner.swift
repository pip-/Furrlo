//
//  PetTabOwner.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/6/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class PetTabOwner: UIViewController {
    
    @IBOutlet var petCollection: UICollectionView!

    let reuseIdentifier = "cell"
    var noPetsReuseIdentifier = "noPets"
    var pets: [String] = []
    var petSpecies: [String] = []

    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    //"Pet 1", "Pet 2", "Pet 3", "Pet 4", "Pet 5", "Pet 6"
    
    //@IBOutlet weak var petPicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Pets"
       //UNCOMMENT THE LINE BELOW TO GET ALL PETS RETURNED AS JSON, INTO STRINGS
        //WHEN A PET IS ADDED, A QUERY IS RUN AND ADDS ALL PETS WITH YOUR USER ID AS PETS IN DATA
       /*get()
        if let fetchedPets = appDelegate.getPets(){
            for pet in fetchedPets{
                pets.append(pet.name!)
            }
        }*/
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        
        pets.removeAll()
        petSpecies.removeAll()
        
        let user = self.appDelegate.getUser()
        let myID = user?.userID
        
        if let fetchedPets = appDelegate.getPets(){
            for pet in fetchedPets{
                if(myID == pet.user?.userID && pet.isSat?.boolValue==false){
                    pets.append(pet.name!)
                    petSpecies.append(pet.species!)
                }
            }
        }
        
        self.petCollection.reloadData()
        //was causing the cells to appear twice
    }
        
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // tell the collection view how many cells to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(pets.count == 0){
            return 1
        } else {
        return self.pets.count
        }
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        if(pets.count == 0){
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(noPetsReuseIdentifier, forIndexPath: indexPath)
            
           
            
            return cell
        }
        else{
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCellOwner
        
            
            
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.petName.text = self.pets[indexPath.item] as? String
        cell.petButton.setTitle(self.pets[indexPath.item], forState: .Normal)
        //cell.petImage.image = self.appDelegate.pickPetPicture(self.petSpecies[indexPath.item])
        
            
        let newSwiftColor = UIColor(red: 238, green: 255, blue: 247, alpha: 0.0)
            
        cell.backgroundColor = newSwiftColor // make cell more visible in our example project

        return cell
        }
        
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if(pets.count == 0){
        
        //let deviceSize = UIScreen.mainScreen().bounds.size
        //let cellSize = sqrt(Double(deviceSize.width * deviceSize.height) / (Double(33)))
        
        let cellWidth = 500
        let cellHeight = 200
        
            return CGSize(width: cellWidth , height: cellHeight)}
        else {
            
           // let deviceSize = UIScreen.mainScreen().bounds.size
            //let cellSize = sqrt(Double(deviceSize.width * deviceSize.height) / (Double(33)))
            
            let cellWidth = 100
            let cellHeight = 150
            
            return CGSize(width: cellWidth , height: cellHeight)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "toPet"){
        let viewController = segue.destinationViewController as! ExistingPetOwner
        if let buttonTitle = (sender as? UIButton)?.titleLabel?.text{
            viewController.petName = buttonTitle
            }}
    }
    
    
    
    
    

    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
}


