//
//  PetTabOwner.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/6/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit

class PetTabOwner: UIViewController {

    let reuseIdentifier = "cell"
    var noPetsReuseIdentifier = "noPets"
    var pets: [String] = []
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    //"Pet 1", "Pet 2", "Pet 3", "Pet 4", "Pet 5", "Pet 6"
    
    //@IBOutlet weak var petPicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Pets"
               /*if let fetchedPets = appDelegate.getPets(){
            for pet in fetchedPets{
                pets.append(pet.name!)
            }
        }*/

        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {

        if let fetchedPets = appDelegate.getPets(){
            for pet in fetchedPets{
                pets.append(pet.name!)
            }
        }
        

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
            cell.petImage.image = UIImage(named: "cat profile.jpg")
            
        let newSwiftColor = UIColor(red: 238, green: 255, blue: 247, alpha: 0.0)
            
        cell.backgroundColor = newSwiftColor // make cell more visible in our example project
        //cell.layer.borderWidth = 1
          //  cell.layer.cornerRadius = 62.5
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
            let cellHeight = 145
            
            return CGSize(width: cellWidth , height: cellHeight)
        }
    }
    
    

    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
}


