//
//  CoreDataStack.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    /** singleton for accessesing CoreDataStack class methods
     */
    static let shared = CoreDataStack()
    private init() {}
    
    lazy var container: NSPersistentContainer = { () -> NSPersistentContainer in
        let container = NSPersistentContainer(name: "StudySwipe")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) throws {
        
        var error: Error?
        context.performAndWait {
            do {
                try context.save()
            } catch let saveError {
                error = saveError
            }
        }
        // If there was an error, the error var will be non nil
        if let error = error {
            throw error
        }
    }
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try self.mainContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                self.mainContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    func resetCoreData() {
        self.deleteAllData("Question")
        self.deleteAllData("Test")
        self.deleteAllData("QuestionObservation")
        self.deleteAllData("QuestionAnalytics")
    }
}

