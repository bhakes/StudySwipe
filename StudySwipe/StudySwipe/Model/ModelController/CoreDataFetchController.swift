//
//  CardsFetchController.swift
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
    
    func filteredQuestions(difficulties: [Difficulty] = [.All], categories: [Category] = [.All], tracks: [Track] = [.All] ) -> [Question]? {
        
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
            
        }
        return result
    }
    
    
    
    
    
    
    
    let context: NSManagedObjectContext
}
