//
//  User+CoreDataProperties.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/27/16.
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
    @NSManaged var name: String?
    @NSManaged var phone: NSNumber?
    @NSManaged var userID: NSNumber?
    @NSManaged var petID: NSSet?
    @NSManaged var trips: NSSet?

}
