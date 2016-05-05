//
//  AppDelegate.swift
//  SitStay
//
//  Created by Philip Gilbreth on 3/25/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let alreadyLaunched = NSUserDefaults.standardUserDefaults().boolForKey("alreadyLaunched")
        if(!alreadyLaunched){
            //Do First Launch stuff
            
            //Creating an instance of 'User'-----------------------------------------
            let user = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: self.managedObjectContext) as! User
            //-----------------------------------------------------------------------
            
           // let entityDescription = NSEntityDescription.
            
            //Modifying values of the created 'User' instance------------------------
            user.userID = Int(arc4random_uniform(800000) + 100000)
            //-----------------------------------------------------------------------
            
            //Saving the changes I made to the instance of 'User'--------------------
            self.saveContext()
            //-----------------------------------------------------------------------
            
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "alreadyLaunched")
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "edu.missouri.cs.SitStay" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("SitStay", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func getUser() -> User?{
        do {
            let fetchedUsers = try self.managedObjectContext.executeFetchRequest(NSFetchRequest(entityName: "User")) as! [User]
            if(fetchedUsers.count >= 1){
                let user = fetchedUsers[0]
                return user
            } else {
                print("Couldn't find user")
                return nil
            }
        } catch {
            fatalError("Failed to fetch users: \(error)")
        }
    }
    
    func updateUserEmail(email: String){
        if let user = getUser(){
            user.email = email
            saveContext()
        }
    }
    
    func updateUserPhone(phone: String){
        if let user = getUser(){
            user.phone = phone
            saveContext()
        }
    }
    
    func getTrips() -> [Trip]?{
        do {
            let fetchedTrips = try self.managedObjectContext.executeFetchRequest(NSFetchRequest(entityName: "Trip")) as! [Trip]
            return fetchedTrips
        } catch {
            fatalError("Failed to fetch trips: \(error)")
        }
    }
    
    func getTripWithID(tripID: Int) -> Trip?{
        do {
            let fetchedTrips = try self.managedObjectContext.executeFetchRequest(NSFetchRequest(entityName: "Trip")) as! [Trip]
            for trip in fetchedTrips{
                if (trip.tripID == tripID){
                    return trip
                }
            }
            return nil
        } catch {
            //fatalError("Failed to fetch trips: \(error)")
            print("Could not find this tripID")
            return nil
        }
    }
    
    func updateTripID(oldID: Int, newID: Int){
        do{
        let fetchedTrips = try self.managedObjectContext.executeFetchRequest(NSFetchRequest(entityName: "Trip")) as! [Trip]
        for trip in fetchedTrips{
            if (trip.tripID == oldID){
                trip.tripID = newID
            }
        }
    }
        catch {
    //fatalError("Failed to fetch trips: \(error)")
    print("Could not find this tripID")
    
    }
    }
    
    func getToDoItems() -> [ToDoItem]?{
        do {
            let fetchedToDoItems = try self.managedObjectContext.executeFetchRequest(NSFetchRequest(entityName: "ToDoItem")) as! [ToDoItem]
            return fetchedToDoItems
        } catch {
            fatalError("Failed to fetch To Do Items: \(error)")
        }
    }
    

    func getPets() -> [Pet]?{
        do {
            let fetchedPets = try self.managedObjectContext.executeFetchRequest(NSFetchRequest(entityName: "Pet"))
            if let castPets = fetchedPets as? [Pet]{
                return castPets
            } else {
                return nil
            }
        } catch {
            fatalError("Failed to fetch trips: \(error)")
        }
    }
    
    func insertNewTrip(startDate: NSDate, endDate: NSDate, street: String, zip: String, city: String, addr2: String?, pets: [Pet], tripName: String, isSitting: Bool, phone: String?, email: String?, user: User) -> Int{
        let trip = NSEntityDescription.insertNewObjectForEntityForName("Trip", inManagedObjectContext: self.managedObjectContext) as! Trip
        
        trip.startDate = startDate
        trip.endDate = endDate
        trip.addr1 = street
        if let addr2 = addr2{
            trip.addr2 = addr2
        }
        trip.zip = zip
        trip.city = city
        trip.tripName = tripName
        
        if(isSitting){
            trip.isSitting = 1
        }
        
        if let phone = phone {
            trip.phone = phone
        }
        if let email = email {
            trip.email = email
        }
        
        trip.tripID = Int(arc4random_uniform(1000000) + 800000)
        
        
        for pet in pets{
            pet.tripID = trip
        }
        
        trip.userID = user
        
        self.saveContext()
        
        return Int(trip.tripID!)
    }
    
    
    func deleteTrip(tripID: Int) -> Bool{
        do{
            let fetchedTrips = try self.managedObjectContext.executeFetchRequest(NSFetchRequest(entityName: "Trip")) as! [Trip]
            for trip in fetchedTrips{
                if trip.tripID == tripID{
                    print("Trying to delete trip: " + trip.tripName!)
                    self.managedObjectContext.deleteObject(trip)
                    self.saveContext()
                    return true
                }
            }
        }
        catch{
            print("Could not delete this trip")
        }
        return false
    }

    
    func insertNewPet(name: String?, species: String?, breed: String?, age: String?, personality: String?, food: String?, notes: String?, isSat: Bool, user: User){
        let newPet = NSEntityDescription.insertNewObjectForEntityForName("Pet", inManagedObjectContext: self.managedObjectContext) as! Pet
        
        
        
        newPet.name = name
        newPet.species = species
        newPet.breed = breed
        newPet.age = age
        newPet.personality = personality
        newPet.food = food
        newPet.notes = notes
        newPet.user = user
        //newPet.picture = picture
        
        if(isSat){
            newPet.isSat = 1
        }
        
        //newPet.petID = Int(arc4random_uniform(8000000) + 100000)
        
        
        self.saveContext()
    }
    
    func deletePet(petName: String) -> Bool{
        do{
            let fetchedPets = try self.managedObjectContext.executeFetchRequest(NSFetchRequest(entityName: "Pet")) as! [Pet]
            for pet in fetchedPets{
                if pet.name == petName{
                    print("Trying to delete pet: " + pet.name!)
                    self.managedObjectContext.deleteObject(pet)
                    self.saveContext()
                    return true
                }
            }
        }
        catch{
            print("Could not delete this pet")
        }
        return false
    }
    
 
    func insertNewToDoItem(complete: NSNumber, instruction: String?, instructionDetail: String?, itemID: NSNumber?, petID: NSNumber?, isSat: Bool, petParent: Pet?){
        let newToDoItem = NSEntityDescription.insertNewObjectForEntityForName("ToDoItem", inManagedObjectContext: self.managedObjectContext) as! ToDoItem;
        
        newToDoItem.complete = complete
        newToDoItem.instruction = instruction
        newToDoItem.instructionDetail = instructionDetail
        newToDoItem.itemID = itemID
        newToDoItem.petID = petID
        newToDoItem.isSat = isSat
        newToDoItem.petParent = petParent
        
    
        if(isSat){
            newToDoItem.isSat = 1
        }

        self.saveContext()
    }
 
    /*
    func deleteToDoItem(itemID: NSNumber) -> Bool{
        do {
            let fetchedToDoItem = try self.managedObjectContext.executeFetchRequest(NSFetchRequest[entityName: "ToDoItem"]) as! [ToDoItem]
            for toDoItem in fetchedToDoItem{
                if ToDoItem.itemId == itemID{
                    print("Trying to delete To Do Item: "+ toDoItem.itemID!)
                    self.managedObjectContext.deletedObject(toDoItem)
                    self.saveContext()
                    return true
                }
            }
        }
        catch {
            print("Could not delete this Task")
        }
        return false
    }
    */
}

