//
//  AnalyticsController.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/2/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation
import CoreData

class AnalyticsController {
    init(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.context = context
    }
    
    // MARK: Question Fetch Methods
    
    func getAllQuestion() -> [Question]? {
        
        var result: [Question]? = nil // create an Question array named 'result' that will store the entries you find in the Persistent Store
        
        self.context.performAndWait {
            
            let fetchRequest: NSFetchRequest<Question> = Question.fetchRequest() // create an Question NSFetchRequest
            
            do { // in the current (background) context, perform the fetch request from the persistent store
                result = try self.context.fetch(fetchRequest) // assign the (error-throwing) fetch request, done on the background context, to result
            } catch {
                NSLog("Error fetching list of Question: \(error)") // if the fetch request throws an error, NSLog it
            }
            
        }
        return result
    }
    
    
    let context: NSManagedObjectContext
}
