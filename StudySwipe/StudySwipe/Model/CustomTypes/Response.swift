//
//  Response.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation

public enum Response: String, Codable {
    case correct = "correct"
    case incorrect = "incorrect"
    case skip = "skip"
}
