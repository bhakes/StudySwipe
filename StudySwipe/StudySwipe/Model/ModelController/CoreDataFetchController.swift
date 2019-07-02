//
//  CoreDataFetchController.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation
import CoreData

class CoreDataFetchController {
    init(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.context = context
    }
    
    // MARK: InterviewTest Manipulation Methods
    
    func makeTest(with title: String, difficulties: [Difficulty] = [.All], categories: [Category] = [.All], tracks: [Track] = [.All], count: Int? = nil, random: Bool = false) -> InterviewTest? {
        
        defer {
            do {
                try CoreDataStack.shared.save()
            } catch {
                print("Failed to save to core data with error: \(error)")
            }
        }
        
        guard let questions = getFilteredQuestions(difficulties: difficulties, categories: categories, tracks: tracks, count: count, random: random) else { return nil }
        
        let newTest = InterviewTest(questions: questions, title: title)
        
        return newTest
    }
    
    func makeTestAndObservation(with title: String, difficulties: [Difficulty] = [.All], categories: [Category] = [.All], tracks: [Track] = [.All], count: Int? = nil, random: Bool = false) -> (InterviewTest?, InterviewTestObservation?) {
        
        defer {
            do {
                try CoreDataStack.shared.save()
            } catch {
                print("Failed to save to core data with error: \(error)")
            }
        }
        
        guard let questions = getFilteredQuestions(difficulties: difficulties, categories: categories, tracks: tracks, count: count, random: random) else { return (nil, nil) }
        
        let newTest = InterviewTest(questions: questions, title: title)
        guard let newTestObservation = makeTestObservation(with: newTest) else { return (newTest, nil)}
        
        return (newTest, newTestObservation)
    }
    
    // MARK: InterviewTestObservation Manipulation Methods
    private func makeTestObservation(with test: InterviewTest) -> InterviewTestObservation? {
        
        let newTestObservation = InterviewTestObservation(interviewTest: test)
        return newTestObservation
    }
    
    private func addQuestionObservation(to testObservation: InterviewTestObservation, for questionObs: QuestionObservation){
        
        testObservation.questionObservations?.append(questionObs)
        testObservation.finishTimestamp = Date()
    }
    
    func finishTestAndFinalizeObservation(_ testObs: inout InterviewTestObservation) {
        print("Finalizing test observation: \(testObs.testID!)")
        defer {
            do {
                try CoreDataStack.shared.save()
            } catch {
                print("Failed to save to core data with error: \(error)")
            }
        }
        
        testObs.isCompleted = true
        testObs.finishTimestamp = Date()
        
    }
    
    // MARK: QuestionObservation Manipulation Methods
    
    private func makeQuestionObservation(with response: Response, for question: Question, in duration: TimeInterval? = nil) -> QuestionObservation? {
        
        guard let questionID = question.questionID else { return nil }
        let newQuestionObservation = QuestionObservation(response: response, question: question, questionID: questionID, timeInterval: duration ?? 0)
        return newQuestionObservation
    }
    
    func recordQuestionObservation(with response: Response, for question: Question, with duration: Int? = nil, in testObs: InterviewTestObservation) -> Bool {
        print("Recording observation with repsonse: \(response), for questionID: \(question.questionID!), with duration: \(duration ?? -1)")
        defer {
            do {
                try CoreDataStack.shared.save()
            } catch {
                print("Failed to save to core data with error: \(error)")
            }
        }
        
        guard let newQuestionObs = makeQuestionObservation(with: response, for: question) else { return false }
        addQuestionObservation(to: testObs, for: newQuestionObs)
        
        return true
        
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
    
    
    /**
     
     
     */
    func getFilteredQuestions(difficulties: [Difficulty] = [.All], categories: [Category] = [.All], tracks: [Track] = [.All], count: Int? = nil, random: Bool = false) -> [Question]? {
        
        var result: [Question]? = nil // create an Question array named 'result' that will store the entries you find in the Persistent Store
        
        self.context.performAndWait {
            
            let fetchRequest: NSFetchRequest<Question> = Question.fetchRequest() // create an Question NSFetchRequest
            
            // add the difficulty predicateInitializer 'init(_:)' requires that 'Difficulty' conform to 'LosslessStringConvertible'
            var difficultyPredicate: NSPredicate?
            
            switch difficulties {
            case [.All]:
                break
            default:
                switch difficulties.count {
                case 0:
                    break
                case 1:
                    difficultyPredicate = NSPredicate(format: "difficulty == %@", argumentArray: difficulties.map { $0.description })
                case 2:
                    difficultyPredicate = NSPredicate(format: "(difficulty == %@) OR (difficulty == %@)", argumentArray: difficulties.map { $0.description })
                default:
                    break
                }
            }
            
            
            // add the categories predicates
            var categoryPredicate: NSPredicate?
            var categoryFormat: String = ""
            switch categories {
            case [.All]:
                break
            default:
                switch categories.count {
                case 0:
                    break
                case 1:
                    categoryPredicate = NSPredicate(format: "category == %@", argumentArray: categories.map { $0.description })
                default:
                    for _ in 0..<(categories.count - 1) {
                        categoryFormat += "(category == %@) OR "
                    }
                    categoryFormat += "(category == %@)"
                    categoryPredicate = NSPredicate(format: categoryFormat, argumentArray: categories.map { $0.description })
                }
            }
            
            // add the track predicates
            var trackPredicate: NSPredicate?
            var trackFormat: String = ""
            switch tracks {
            case [.All]:
                break
            default:
                switch tracks.count {
                case 0:
                    break
                case 1:
                    trackPredicate = NSPredicate(format: "track == %@", argumentArray: tracks.map { $0.description })
                default:
                    for _ in 0..<(tracks.count - 1) {
                        trackFormat += "(track == %@) OR "
                    }
                    trackFormat += "(track == %@)"
                    trackPredicate = NSPredicate(format: trackFormat, argumentArray: tracks.map { $0.description })
                }
            }
            
            // Create a subPredicate array and append each of the component predicates if available
            var subPredicates: [NSPredicate] = []
            if let difficultyPredicate = difficultyPredicate {
                subPredicates.append(difficultyPredicate)
            }
            if let categoryPredicate = categoryPredicate {
                subPredicates.append(categoryPredicate)
            }
            if let trackPredicate = trackPredicate {
                subPredicates.append(trackPredicate)
            }
            
            // if the subPredicates array is greater than zero, create and AND compound predicate and add that compound predicate to the fetchRequest.predicate property
            if subPredicates.count > 0 {
                let andPredicate = NSCompoundPredicate(type: .and, subpredicates: subPredicates)
                fetchRequest.predicate = andPredicate
            }
            
            do { // in the current (background) context, perform the fetch request from the persistent store
                result = try self.context.fetch(fetchRequest) // assign the (error-throwing) fetch request, done on the background context, to result
            } catch {
                NSLog("Error fetching list of Question: \(error)") // if the fetch request throws an error, NSLog it
            }
            
            // randomize and truncate the results accordingly
            if let count = count {
                if random {
                    result = result?.count ?? count + 1 > count ? Array((result?.shuffled().prefix(count))!) : result
                } else {
                    result = result?.count ?? count + 1 > count ? Array((result?.prefix(count))!) : result
                }
            } else {
                if random {
                    result = Array((result?.shuffled())!)
                }
            }
            
        }
        return result
    }
    
    
    // MARK: QuestionObservation Fetch Methods
    
    
    func getAllQuestionObservations() -> [QuestionObservation]? {
        
        var result: [QuestionObservation]? = nil // create an QuestionObservation array named 'result' that will store the entries you find in the Persistent Store
        
        self.context.performAndWait {
            
            let fetchRequest: NSFetchRequest<QuestionObservation> = QuestionObservation.fetchRequest() // create an QuestionObservation NSFetchRequest
            
            do { // in the current (background) context, perform the fetch request from the persistent store
                result = try self.context.fetch(fetchRequest) // assign the (error-throwing) fetch request, done on the background context, to result
            } catch {
                NSLog("Error fetching list of QuestionObservations: \(error)") // if the fetch request throws an error, NSLog it
            }
            
        }
        return result
    }
    
    func getQuestionObservationsByUUID(with uuid: UUID) -> [QuestionObservation]? {
        
        var result: [QuestionObservation]? = nil // create an QuestionObservation array named 'result' that will store the entries you find in the Persistent Store
        
        self.context.performAndWait {
            
            let fetchRequest: NSFetchRequest<QuestionObservation> = QuestionObservation.fetchRequest() // create an QuestionObservation NSFetchRequest
            
            let uuidPredicate = NSPredicate(format: "questionID == %@", uuid.uuidString)
            fetchRequest.predicate = uuidPredicate
            
            do { // in the current (background) context, perform the fetch request from the persistent store
                result = try self.context.fetch(fetchRequest) // assign the (error-throwing) fetch request, done on the background context, to result
            } catch {
                NSLog("Error fetching list of QuestionObservations: \(error)") // if the fetch request throws an error, NSLog it
            }
            
        }
        return result
    }
    
    func getFilteredQuestionObservations(difficulties: [Difficulty] = [.All], categories: [Category] = [.All], tracks: [Track] = [.All], count: Int? = nil, random: Bool = false) -> [QuestionObservation]? {
        
        var result: [QuestionObservation]? = nil // create an Question array named 'result' that will store the entries you find in the Persistent Store
        
        self.context.performAndWait {
            
            let fetchRequest: NSFetchRequest<QuestionObservation> = QuestionObservation.fetchRequest() // create an Question NSFetchRequest
            
            // add the difficulty predicateInitializer 'init(_:)' requires that 'Difficulty' conform to 'LosslessStringConvertible'
            var difficultyPredicate: NSPredicate?
            
            switch difficulties {
            case [.All]:
                break
            default:
                switch difficulties.count {
                case 0:
                    break
                case 1:
                    difficultyPredicate = NSPredicate(format: "question.difficulty == %@", argumentArray: difficulties.map { $0.description })
                case 2:
                    difficultyPredicate = NSPredicate(format: "(question.difficulty == %@) OR (question.difficulty == %@)", argumentArray: difficulties.map { $0.description })
                default:
                    break
                }
            }
            
            
            // add the categories predicates
            var categoryPredicate: NSPredicate?
            var categoryFormat: String = ""
            switch categories {
            case [.All]:
                break
            default:
                switch categories.count {
                case 0:
                    break
                case 1:
                    categoryPredicate = NSPredicate(format: "question.category == %@", argumentArray: categories.map { $0.description })
                default:
                    for _ in 0..<(categories.count - 1) {
                        categoryFormat += "(question.category == %@) OR "
                    }
                    categoryFormat += "(question.category == %@)"
                    categoryPredicate = NSPredicate(format: categoryFormat, argumentArray: categories.map { $0.description })
                }
            }
            
            // add the track predicates
            var trackPredicate: NSPredicate?
            var trackFormat: String = ""
            switch tracks {
            case [.All]:
                break
            default:
                switch tracks.count {
                case 0:
                    break
                case 1:
                    trackPredicate = NSPredicate(format: "question.track == %@", argumentArray: tracks.map { $0.description })
                default:
                    for _ in 0..<(tracks.count - 1) {
                        trackFormat += "(question.track == %@) OR "
                    }
                    trackFormat += "(question.track == %@)"
                    trackPredicate = NSPredicate(format: trackFormat, argumentArray: tracks.map { $0.description })
                }
            }
            
            // Create a subPredicate array and append each of the component predicates if available
            var subPredicates: [NSPredicate] = []
            if let difficultyPredicate = difficultyPredicate {
                subPredicates.append(difficultyPredicate)
            }
            if let categoryPredicate = categoryPredicate {
                subPredicates.append(categoryPredicate)
            }
            if let trackPredicate = trackPredicate {
                subPredicates.append(trackPredicate)
            }
            
            // if the subPredicates array is greater than zero, create and AND compound predicate and add that compound predicate to the fetchRequest.predicate property
            if subPredicates.count > 0 {
                let andPredicate = NSCompoundPredicate(type: .and, subpredicates: subPredicates)
                fetchRequest.predicate = andPredicate
            }
            
            do { // in the current (background) context, perform the fetch request from the persistent store
                result = try self.context.fetch(fetchRequest) // assign the (error-throwing) fetch request, done on the background context, to result
            } catch {
                NSLog("Error fetching list of QuestionObservations: \(error)") // if the fetch request throws an error, NSLog it
            }
            
            // if there are no results, early return
            guard var result = result else { return }
            
            // randomize and truncate the results accordingly
            if let count = count {
                if random {
                    result = result.count > count ? Array(result.shuffled().prefix(count)) : result
                } else {
                    result = result.count > count ? Array(result.prefix(count)) : result
                }
            } else {
                if random {
                    result = Array(result.shuffled())
                }
            }
            
        }
        return result
    }
    
    
    // MARK: InterviewTestObservation Fetch Methods
    
    func getAllInterviewTestObservations() -> [InterviewTestObservation]? {
        
        var result: [InterviewTestObservation]? = nil // create an InterviewTestObservation array named 'result' that will store the entries you find in the Persistent Store
        
        self.context.performAndWait {
            
            let fetchRequest: NSFetchRequest<InterviewTestObservation> = InterviewTestObservation.fetchRequest() // create an InterviewTestObservation NSFetchRequest
            
            do { // in the current (background) context, perform the fetch request from the persistent store
                result = try self.context.fetch(fetchRequest) // assign the (error-throwing) fetch request, done on the background context, to result
            } catch {
                NSLog("Error fetching list of QuestionObservations: \(error)") // if the fetch request throws an error, NSLog it
            }
            
        }
        return result
    }
    
    func getInterviewTestObservationsByUUID(with testID: UUID) -> [InterviewTestObservation]? {
        
        var result: [InterviewTestObservation]? = nil // create an InterviewTestObservation array named 'result' that will store the entries you find in the Persistent Store
        
        self.context.performAndWait {
            
            let fetchRequest: NSFetchRequest<InterviewTestObservation> = InterviewTestObservation.fetchRequest() // create an InterviewTestObservation NSFetchRequest
            
            let uuidPredicate = NSPredicate(format: "testID == %@", testID.uuidString)
            fetchRequest.predicate = uuidPredicate
            
            do { // in the current (background) context, perform the fetch request from the persistent store
                result = try self.context.fetch(fetchRequest) // assign the (error-throwing) fetch request, done on the background context, to result
            } catch {
                NSLog("Error fetching list of InterviewTestObservation: \(error)") // if the fetch request throws an error, NSLog it
            }
            
        }
        return result
    }
    
    
    let context: NSManagedObjectContext
}
