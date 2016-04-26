//
//  Pet+CoreDataProperties.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/24/16.
//  Copyright © 2016 GroupA. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Pet {

    @NSManaged var age: String?
    @NSManaged var breed: String?
    @NSManaged var name: String?
    @NSManaged var notes: String?
    @NSManaged var personality: String?
    @NSManaged var petID: NSNumber?
    @NSManaged var species: String?
    @NSManaged var food: String?
    @NSManaged var tripID: Trip?

}
