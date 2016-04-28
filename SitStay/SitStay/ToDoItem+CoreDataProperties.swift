//
//  ToDoItem+CoreDataProperties.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/28/16.
//  Copyright © 2016 GroupA. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ToDoItem {

    @NSManaged var complete: NSNumber?
    @NSManaged var instruction: String?
    @NSManaged var itemID: NSNumber?
    @NSManaged var instructionDetail: String?
    @NSManaged var petParent: Pet?

}
