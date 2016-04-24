//
//  Trip+CoreDataProperties.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/21/16.
//  Copyright © 2016 GroupA. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Trip {

    @NSManaged var destination: String?
    @NSManaged var endDate: NSDate?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var startDate: NSDate?
    @NSManaged var tripID: NSNumber?
    @NSManaged var addr1: String?
    @NSManaged var addr2: String?
    @NSManaged var zip: String?
    @NSManaged var city: String?
    @NSManaged var tripName: String?
    @NSManaged var userID: User?
    @NSManaged var petID: Pet?

}
