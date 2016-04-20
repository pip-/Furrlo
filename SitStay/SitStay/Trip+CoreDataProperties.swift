//
//  Trip+CoreDataProperties.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/20/16.
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
    @NSManaged var location: String?
    @NSManaged var startDate: NSDate?
    @NSManaged var tripID: NSNumber?
    @NSManaged var userID: User?

}
