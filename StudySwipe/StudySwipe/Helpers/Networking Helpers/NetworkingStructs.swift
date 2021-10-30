//
//  NetworkingStructs.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation

struct QuestionTopLevel: Codable {
    let values: [[String]]
    
    enum CodingKeys: String, CodingKey {
        case values
    }
    
}
