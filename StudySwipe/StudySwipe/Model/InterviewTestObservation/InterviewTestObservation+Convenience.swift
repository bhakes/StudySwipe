//
//  InterviewTestObservation+Convenience.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation
import CoreData

extension InterviewTestObservation {
    
    convenience init(finishTimestamp: Date,
                     startTimestamp: Date,
                     testID: UUID = UUID(),
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context:context)
        
        self.finishTimestamp = finishTimestamp
        self.startTimestamp = startTimestamp
        self.testID = testID
    }
    
    
    convenience init(interviewTest: InterviewTest,
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context:context)
    
        self.testID = interviewTest.testID
        self.title = interviewTest.title
        self.startTimestamp = interviewTest.timestamp
    }
    
}
