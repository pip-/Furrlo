//
//  Trip+CoreDataProperties.swift
//  SitStay
//
<<<<<<< HEAD
//  Created by Philip Gilbreth on 4/30/16.
=======
//  Created by Philip Gilbreth on 4/24/16.
>>>>>>> parent of 1000481... Trying to get Owner to work
//  Copyright © 2016 GroupA. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Trip {

    @NSManaged var addr1: String?
    @NSManaged var addr2: String?
    @NSManaged var city: String?
    @NSManaged var endDate: NSDate?
<<<<<<< HEAD
    @NSManaged var isSitting: NSNumber?
=======
>>>>>>> parent of 1000481... Trying to get Owner to work
    @NSManaged var startDate: NSDate?
    @NSManaged var tripID: NSNumber?
    @NSManaged var tripName: String?
    @NSManaged var zip: String?
<<<<<<< HEAD
    @NSManaged var phone: String?
    @NSManaged var email: String?
=======
>>>>>>> parent of 1000481... Trying to get Owner to work
    @NSManaged var pets: NSSet?
    @NSManaged var userID: User?

}
