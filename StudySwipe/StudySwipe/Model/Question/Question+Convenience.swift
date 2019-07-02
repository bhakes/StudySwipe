//
//  Question+Convenience.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation
import CoreData

extension Question {
    
    convenience init(answer: String,
                     category: Category,
                     difficulty: Difficulty,
                     question: String,
                     questionID: UUID? = UUID(),
                     track: Track,
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        
        self.init(context:context)
        
        self.answer = answer
        self.category = category.rawValue
        self.difficulty = difficulty.rawValue
        self.question = question
        self.questionID = questionID
        self.track = track.rawValue
        
    }
    
    
    convenience init(questionRepresentation: QuestionRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        let answer = questionRepresentation.answer.answer
        let category = questionRepresentation.category.category
        let difficulty = questionRepresentation.difficulty.difficulty
        let question = questionRepresentation.question.question
        let questionID = questionRepresentation.questionID.questionID
        let track = questionRepresentation.track.track
        
        self.init(answer: answer, category: category, difficulty: difficulty, question: question, questionID: questionID, track: track, context: context)
    }
}
