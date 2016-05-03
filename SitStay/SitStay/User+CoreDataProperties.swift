//
//  User+CoreDataProperties.swift
//  SitStay
//
<<<<<<< HEAD
//  Created by Philip Gilbreth on 4/30/16.
=======
//  Created by Philip Gilbreth on 4/20/16.
>>>>>>> parent of 1000481... Trying to get Owner to work
//  Copyright © 2016 GroupA. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var address: String?
    @NSManaged var email: String?
<<<<<<< HEAD
    @NSManaged var name: String?
    @NSManaged var phone: String?
    @NSManaged var userID: NSNumber?
    @NSManaged var petID: NSSet?
    @NSManaged var trips: NSSet?
=======
    @NSManaged var isSitting: NSNumber?
    @NSManaged var name: String?
    @NSManaged var phone: NSNumber?
    @NSManaged var userID: NSNumber?
    @NSManaged var petID: NSManagedObject?
>>>>>>> parent of 1000481... Trying to get Owner to work

}
