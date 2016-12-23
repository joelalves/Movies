//
//  CoreDataManager.swift
//  Movies
//
//  Created by Joel Alves on 14/11/16.
//  Copyright © 2016 Joel Alves. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let sharedInstance : CoreDataManager = {
        return CoreDataManager()
    }()
    
    // Applications default directory address
    lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory , in: .userDomainMask)
        return urls[urls.count - 1]
        
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        if let modelURL = Bundle.main.url(forResource: "Model", withExtension: "momd"),
            let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) {
            return managedObjectModel
        }
        return NSManagedObjectModel()
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        do {
            let url = self.applicationDocumentsDirectory.appendingPathComponent("Model.sqlite")
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch let error as NSError {
            debugPrint("Ops there was an error \(error.localizedDescription)")
            abort()
        }
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
        return context
    }()
    
    func saveContext() {
        if self.managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                debugPrint("Ops there was an error \(error.localizedDescription)")
                abort()
            }
        }
    }
}


extension CoreDataManager {
    class func newObject(entityName:String) -> NSManagedObject?{
        if let _ = NSEntityDescription.entity(forEntityName: entityName, in: CoreDataManager.sharedInstance.managedObjectContext) {
            let newObject = NSEntityDescription.insertNewObject(forEntityName: entityName, into: CoreDataManager.sharedInstance.managedObjectContext)
            return newObject
        }
        return nil
    }
    
    class func temporaryObject(entityName:String) ->NSManagedObject?{
        if let description = NSEntityDescription.entity(forEntityName: entityName, in: CoreDataManager.sharedInstance.managedObjectContext) {
            let temporayObject = NSManagedObject(entity: description, insertInto: nil)
            return temporayObject
        }
        return nil
    }
    
}
