//
//  InterviewTest+Convenience.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation
import CoreData

extension InterviewTest {
    
    convenience init(questions: [Question],
                     title: String,
                     timestamp: Date? = Date(),
                     testID: UUID? = UUID(),
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        
        self.init(context:context)
        
        self.questions = questions
        self.title = title
        self.timestamp = timestamp
        self.testID = testID
    }
    
}
