//
//  QuestionObservation+Convenience.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation
import CoreData

extension QuestionObservation {
    
    convenience init(response: Response,
                     questionID: UUID,
                     timeInterval: Int,
                     timestamp: Date = Date(),
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        
        self.init(context:context)
        
        self.response = response.rawValue
        self.questionID = questionID
        self.timeInterval = Int64(timeInterval)
        self.timestamp = timestamp
        
    }
    
}
