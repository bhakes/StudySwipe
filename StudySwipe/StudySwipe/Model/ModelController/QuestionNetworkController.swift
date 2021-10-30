//
//  QuestionNetworkController.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation
import CoreData

class QuestionNetworkController {
    
    // MARK: - Private Methods
    static let shared = QuestionNetworkController()
    private init (){}
    
    /*
     Generic apiRequest
     */
    private func apiRequest<T: Codable>(from urlRequest: URLRequest,
                                        using session: URLSession = URLSession.shared,
                                        completion: @escaping (T?, Error?) -> Void) {
        
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "com.lambdaSchool.ErrorDomain", code: -1, userInfo: nil))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let decodedObject = try jsonDecoder.decode(T.self, from: data)
                completion(decodedObject, nil)
            } catch {
                print("Error:\(error)")
                completion(nil, error)
            }
            }.resume()
    }
    
    func loadJson<T: Decodable>(filename fileName: String,
                                completion: @escaping (T?, Error?) -> Void) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let decodedObject = try decoder.decode(T.self, from: data)
                completion(decodedObject, nil)
            } catch {
                print("error:\(error)")
                completion(nil, error)
            }
        }
    }
    
    
    
    // MARK: - Product Networking
    
    /*
     Get the latest list of Questions
     */
    func getQuestions(completion: @escaping (QuestionTopLevel?, Error?) -> Void) {
        
        loadJson(filename: "questions") { (results: QuestionTopLevel?, error: Error?) in
            if let error = error {
                print("Error: \(error)")
                completion(nil, error)
            }
            
            guard let results = results else {
                return completion(nil, nil)
            }
            
            
            
            let questionRepresentations: [QuestionRepresentation] = {
                return results.values.compactMap { questionArray in
                    guard questionArray.count == 7 else {
                        return nil
                    }
                    return QuestionRepresentation(answer: questionArray[6],
                                                  category: questionArray[1],
                                                  difficulty: questionArray[3],
                                                  question: questionArray[5],
                                                  questionID: questionArray[2],
                                                  track: questionArray[3])
                }
            }()
            
            
            self.coreDataImporter.syncQuestions(questionRepresentations: questionRepresentations)
            
            completion(results, nil)
            return
        }
    }
    
    
    // MARK: - Properties
    
    var coreDataImporter = CoreDataImporter()
    
}
