//
//  NetworkingStructs.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation

struct QuestionTopLevel: Codable {
    let feed: FeedLevel
    
    enum CodingKeys: String, CodingKey {
        case feed
    }
    
}

struct FeedLevel: Codable {
    let entry: [QuestionRepresentation]
    
    enum CodingKeys: String, CodingKey {
        case entry
    }
    
}
