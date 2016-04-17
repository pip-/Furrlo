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
    var items = ["Pet 1", "Pet 2", "Pet 3", "Pet 4", "Pet 5", "Pet 6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My Pets"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // tell the collection view how many cells to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCellOwner
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.petButton.setTitle(self.items[indexPath.item], forState: .Normal)
        cell.backgroundColor = UIColor.yellowColor() // make cell more visible in our example project
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 20
        
        
        
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
}


