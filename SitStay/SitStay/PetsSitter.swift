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
    
    var items = []
    //"Pet 1", "Pet 2", "Pet 3", "Pet 4", "Pet 5", "Pet 6"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // tell the collection view how many cells to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(items.count == 0){
        return 1
    } else {
        return self.items.count
        }
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if(items.count == 0){
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(noPetsReuseIdentifier, forIndexPath: indexPath)
            
            
            
            return cell
        }
        else{
            
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CellSitter
            
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.petButton.setTitle(self.items[indexPath.item] as! String , forState: .Normal)
            cell.backgroundColor = UIColor.yellowColor() // make cell more visible in our example project
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 20
            return cell
        }

    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if(items.count == 0){
            
            //let deviceSize = UIScreen.mainScreen().bounds.size
            //let cellSize = sqrt(Double(deviceSize.width * deviceSize.height) / (Double(33)))
            
            let cellWidth = 500
            let cellHeight = 200
            
            return CGSize(width: cellWidth , height: cellHeight)}
        else {
            
            // let deviceSize = UIScreen.mainScreen().bounds.size
            //let cellSize = sqrt(Double(deviceSize.width * deviceSize.height) / (Double(33)))
            
            let cellWidth = 100
            let cellHeight = 100
            
            return CGSize(width: cellWidth , height: cellHeight)
        }
    }

    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
}
