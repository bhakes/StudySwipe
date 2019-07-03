//
//  Quotes.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/3/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation

class Quotes {
    
    static let quotes: [(String, String)]  =  [
        ("Dr. Seuss", "The more that you read, the more things you will know. The more that you learn, the more places you’ll go."),
        ("Leonardo da Vinci", "Learning never exhausts the mind."),
        ("Confucius", "Learn as if you were not reaching your goal and as though you were scared of missing it"),
        ("Albert Einstein" , "Intellectual growth should commence at birth and cease only at death."),
        ("B.B. King", "The beautiful thing about learning is that nobody can take it away from you."),
        ("Henry Ford", "Anyone who stops learning is old, whether at twenty or eighty. Anyone who keeps learning stays young.")
        ]
    static var currentIndex = 0
    
    static func getNewQuote() -> (String, String) {
        guard let random = quotes.randomElement() else {
            return (quotes.first!)
        }
        return random
    }
}
