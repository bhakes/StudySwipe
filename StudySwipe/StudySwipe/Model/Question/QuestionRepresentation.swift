//
//  QuestionRepresentation.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation

struct QuestionRepresentation {
    var answer: String
    var category: Category
    var difficulty: Difficulty
    var question: String
    var questionID: UUID
    var track: Track
    
    enum CodingKeys: String, CodingKey {
        case answer
        case category
        case difficulty
        case question
        case questionID
        case track
    }
}
