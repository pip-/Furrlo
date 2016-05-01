//
//  Trip+CoreDataProperties.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/30/16.
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
    @NSManaged var isSitting: NSNumber?
    @NSManaged var startDate: NSDate?
    @NSManaged var tripID: NSNumber?
    @NSManaged var tripName: String?
    @NSManaged var zip: String?
    @NSManaged var phone: String?
    @NSManaged var email: String?
    @NSManaged var pets: NSSet?
    @NSManaged var userID: User?

}
