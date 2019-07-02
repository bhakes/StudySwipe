//
//  QuestionRepresentation.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation

struct QuestionRepresentation: Codable {
    var answer: GSXAnswer
    var category: GSXCategory
    var difficulty: GSXDifficulty
    var question: GSXQuestion
    var questionID: GSXQuestionID
    var track: GSXTrack
    
    enum CodingKeys: String, CodingKey {
    
        case answer = "gsx$answer"
        case category = "gsx$category"
        case difficulty = "gsx$difficulty"
        case question = "gsx$question"
        case questionID = "gsx$questionid"
        case track = "gsx$track"
    }
    
}

struct GSXAnswer: Codable {
    let answer: String
    
    enum CodingKeys: String, CodingKey {
        case answer = "$t"
    }
}

struct GSXCategory: Codable {
    let category: Category
    
    enum CodingKeys: String, CodingKey {
        case category = "$t"
    }
}

struct GSXDifficulty: Codable {
    let difficulty: Difficulty
    
    enum CodingKeys: String, CodingKey {
        case difficulty = "$t"
    }
}

struct GSXQuestion: Codable {
    let question: String
    
    enum CodingKeys: String, CodingKey {
        case question = "$t"
    }
}

struct GSXQuestionID: Codable {
    let questionID: UUID
    
    enum CodingKeys: String, CodingKey {
        case questionID = "$t"
    }
}

struct GSXTrack: Codable {
    let track: Track
    
    enum CodingKeys: String, CodingKey {
        case track = "$t"
    }
}
