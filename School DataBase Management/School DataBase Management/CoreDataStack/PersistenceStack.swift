//
//  NSManagedObjectExtension.swift
//  School DataBase Management
//
//  Created by Aishwarya on 22/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//


//  NSManagedObject+extension.swift
//  Books Dairy
//
//  Created by Shreesha on 27/06/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation
import CoreData
/*
 THE STACK
 ---------
 | Store |
 ---------
 |
 -------------------------------
 | PersistenceStoreCoordinator |
 -------------------------------
 |
 ------------------
 | PrivateContext |
 ------------------
 |
 ---------------
 | MainContext | <---- Single Source of truth
 ---------------
 /|\
 / | \
 /  |  \
 /   |   \
 /    |    \
 /     |     \
 /      |      \
 /       |       \
 /        |        \
 /         |         \
 *************  *************  *************
 | Child MOC |  | Child MOC |  | Child MOC |
 *************  *************  *************
 */
private let kModelName = "School_DataBase_Management"
final class PersistenceStack {
    
    static let sharedInstance = PersistenceStack(modelName: kModelName)
    
    
    /** Main context for use in View Controllers, Fetch Results Controllers etc. */
    private(set) var mainContext: NSManagedObjectContext = {
        let context = PersistenceStack.createMainContext()
        return context
    }()
    
    /** Private context: Parent of main context. */
     private(set) var privateContext: NSManagedObjectContext = {
        let context = PersistenceStack.createPrivateContext()
        return context
    }()
    
    
    private init(modelName: String) {
        buildStack(modelName: modelName)
    }
    
    private func buildStack(modelName: String) {
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension:"momd") else {
            //   log.severe("Error loading model from bundle")
            fatalError("Error loading model from bundle")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        privateContext.persistentStoreCoordinator = coordinator
        
        mainContext.parent = privateContext
        DispatchQueue.global(qos: .background).async {
            let psc = self.privateContext.persistentStoreCoordinator
            
            let storeURL = self.storeURL()
            
            let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
            do {
                try psc?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL as URL?, options: options)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }
    
    private func storeURL() -> NSURL? {
        let urls = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
        let docURL = urls.last
        
        let storeURL = docURL?.appendingPathComponent("\(kModelName).sqlite")
        
        return storeURL as NSURL?
    }
    
    private static func createMainContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        return context
    }
    
    private static func createPrivateContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        return context
    }
    
 
    func save() {
        
        guard (self.mainContext.hasChanges || self.privateContext.hasChanges) else {
            return
        }
        mainContext.performAndWait { () -> Void in
            do {
                try self.mainContext.save()
                self.privateContext.perform { () -> Void in
                    do {
                        try self.privateContext.save()
                        print("Data Saved")
                    } catch{
                        print("Error saving privateContext \(error)")
                    }
                }
            } catch {
                print("Error saving mainContext \(error)")
            }
        }
    }
    
    func createChildContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        context.parent = mainContext
        return context
    }
    
    func reset() {
        let persistentStoreCoordinator = privateContext.persistentStoreCoordinator
        
        mainContext.reset()
        privateContext.reset()
        
        let stores = persistentStoreCoordinator?.persistentStores
        
        guard let persistentStores = stores else {
            print("No stores. Cannot Reset")
            return
        }
        
        for store in persistentStores {
            do {
                try persistentStoreCoordinator?.remove(store)
            } catch {
                print("Failed to remove Persistent Store: \(error)")
            }
        }
        
        
        do {
            
            let storeURL = self.storeURL()
            try FileManager.default.removeItem(at: storeURL! as URL)
            
        } catch {
            print("Failed to remove store file: \(error)")
        }
        
        mainContext = PersistenceStack.createMainContext()
        privateContext = PersistenceStack.createPrivateContext()
        buildStack(modelName: kModelName)
    }
}
