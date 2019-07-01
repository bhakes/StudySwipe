//
//  CoreDataImporter.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation
import CoreData

class CoreDataImporter {
    init(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.context = context
    }
    
    func syncQuestions(questionRepresentations: [QuestionRepresentation], completion: @escaping (Error?) -> Void = { _ in }) {
        
        self.context.perform {
            
            // Delete all the Question data
            CoreDataStack.shared.deleteAllData("Question")

            // Load all the questions
            for questionRepresentation in questionRepresentations {
                _ = Question(questionRepresentation: questionRepresentation, context: self.context)
            }
            
            do {
                try self.context.save()
            } catch let saveError {
                print("Error saving context: \(saveError)")
            }
            
            completion(nil)
        }
    }
    
    
    private func updateQuestion(question: Question, with questionRepresentation: QuestionRepresentation) {
        question.answer = questionRepresentation.answer.answer
        question.category = questionRepresentation.category.category.rawValue
        question.difficulty = questionRepresentation.difficulty.difficulty.rawValue
        question.question = questionRepresentation.question.question
    }

    
    let context: NSManagedObjectContext
}

