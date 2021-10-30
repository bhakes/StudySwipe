//
//  QuestionRepresentation.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation

struct QuestionRepresentation: Codable {
    var answer: String
    var category: String
    var difficulty: String
    var question: String
    var questionID: String
    var track: String
}
