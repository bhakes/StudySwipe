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
    
    
    
    // MARK: - Product Networking
    
    /*
     Get the latest list of Questions
     */
    func getQuestions(completion: @escaping (QuestionTopLevel?, Error?) -> Void) {
        
        let request = createRequest(for: .GETQuestions)
        
        apiRequest(from: request) { (results: QuestionTopLevel?, error: Error?) in
            
            if let error = error {
                print("Error: \(error)")
                completion(nil, error)
            }
            
            guard let results = results else {
                return completion(nil, nil)
            }
            
            self.coreDataImporter.syncQuestions(questionRepresentations: results.feed.entry)
            
            completion(results, nil)
            return
        }
    }
    
    
    // MARK: - Properties
    
    let baseURL =  { () -> URL in
        let urlString =  "https://spreadsheets.google.com/feeds/list/\(APIKeys.questionsGoogleSheetsKey)/od6/public/values?alt=json"
        let url = URL(string: urlString)!
        return url
    }()
    
    var coreDataImporter = CoreDataImporter()
    
}

extension QuestionNetworkController {
    
    // URLRequest Creation
    func createRequest(for apiCallType: APICallType) -> URLRequest {
        
        switch apiCallType {
            
        // questions
        case .GETQuestions:
            
            let url = baseURL
        
            // Create a GET request
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.GET.rawValue
            
            return request

        }
        
    }
}
