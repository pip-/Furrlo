//
//  Sitter_Pets.swift
//  Sitter_PetTab
//
//  Created by MU IT Program on 3/30/16.
//  Copyright © 2016 Megan Cochran. All rights reserved.
//

import UIKit

class PetsSitter: UIViewController {
    
    let reuseIdentifier = "cell"
    var noPetsReuseIdentifier = "noPets"
    
    
    
    var pets: [String] = []
    //"Pet 1", "Pet 2", "Pet 3", "Pet 4", "Pet 5", "Pet 6"
    
    var numSections = 1
    var tripNames: [String] = []
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let fetchedTrips = appDelegate.getTrips(){
            for trip in fetchedTrips{
                if(trip.isSitting!.boolValue == true){
                    if(tripNames.count > 0){
                        numSections = tripNames.count
                    }
                }
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return numSections
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
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CellSitter
            
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.petName.text = self.pets[indexPath.item] as? String
            cell.petImage.image = UIImage(named: "cat profile.jpg")
            cell.petButton.setTitle(self.pets[indexPath.item], forState: .Normal)
            
            let newSwiftColor = UIColor(red: 238, green: 255, blue: 247, alpha: 0.0)
            cell.backgroundColor = newSwiftColor
            // make cell more visible in our example project
            //cell.layer.borderWidth = 1
            //cell.layer.cornerRadius = 20
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

    /*func collectionView(collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String,atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        //1
        switch kind {
        //2
        case UICollectionElementKindSectionHeader:
            //3
            let headerView =
                collectionView.dequeueReusableSupplementaryViewOfKind(kind,withReuseIdentifier: "header",forIndexPath: indexPath)as! supplementaryView
            headerView.label.text = ""
            return headerView
        default:
            //4
            assert(false, "Unexpected element kind")
        }
    }*/
    
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
       
}
