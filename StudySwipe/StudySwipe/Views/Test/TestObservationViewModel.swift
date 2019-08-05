//
//  TestObservationViewModel.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 8/3/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class TestObservationViewModel {

    static var timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        return formatter
    }()

    var testObservation: InterviewTestObservation {
        didSet {
            summarizedCategories = summarizeCategories()
            summarizedQuestions = summarizeQuestions()
        }
    }

    var duration: String {
        var durationString: String?
        if let startTime = testObservation.startTimestamp, let finishTime = testObservation.finishTimestamp {
            let duration = DateInterval(start: startTime, end: finishTime).duration
            durationString = TestObservationViewModel.timeFormatter.string(from: duration)
        }
        return [testObservation.title, durationString].compactMap{$0}.joined(separator: " – ")
    }

    lazy var summarizedCategories: [CategoryViewModel] = summarizeCategories()
    lazy var summarizedQuestions: [QuestionViewModel] = summarizeQuestions()

    struct CategoryViewModel {
        let color: UIColor
        let total: Int
        let correct: Int
        let title: String
    }
    
    struct QuestionViewModel {
        let color: UIColor
        let isCorrect: Bool
        let question: String
    }

    init (interviewTestObservation: InterviewTestObservation) {
        self.testObservation = interviewTestObservation
    }

    private func summarizeCategories() -> [CategoryViewModel] {
        guard let questionObservations = testObservation.questionObservation?.array as? Array<QuestionObservation> else { return sampleCategories }
        let questions = questionObservations.compactMap { $0.question }
        if questions.isEmpty { return sampleCategories }
        let categories = Set(questions.compactMap{ $0.category }.compactMap{ Category(rawValue: $0) })
        let viewModels = categories.map { cat -> CategoryViewModel in
            let questions = questionObservations.filter{ $0.question?.category == cat.description }
            let correct = questions.filter { $0.response == Response.correct.rawValue }
            return CategoryViewModel(color: cat.color(),
                              total: questions.count,
                              correct: correct.count,
                              title: cat.title())
        }

        return viewModels
    }
    
    private let sampleCategories = [
        CategoryViewModel(color: .swift, total: 4, correct: 2, title: "Swift"),
        CategoryViewModel(color: .categoryDefault2, total: 2, correct: 2, title: "OOP"),
        CategoryViewModel(color: .categoryDefault3, total: 3, correct: 1, title: "Objective-C"),
        CategoryViewModel(color: .categoryDefault4, total: 1, correct: 1, title: "Foundation")
    ]
    
    private func summarizeQuestions() -> [QuestionViewModel] {
        return sampleQuestions
    }
    
    private let sampleQuestions = [
        QuestionViewModel(color: .swift, isCorrect: true, question: "This would be the first question."),
        QuestionViewModel(color: .swift, isCorrect: true, question: "This would be the second question."),
        QuestionViewModel(color: .categoryDefault3, isCorrect: false, question: "This would be the third question. You can see that it cuts off."),
        QuestionViewModel(color: .categoryDefault2, isCorrect: true, question: "This would be the fourth question."),
        QuestionViewModel(color: .categoryDefault4, isCorrect: true, question: "This would be the fifth question."),
        QuestionViewModel(color: .categoryDefault1, isCorrect: false, question: "This would be the sixth question."),
        QuestionViewModel(color: .categoryDefault2, isCorrect: true, question: "This would be the seventh question."),
        QuestionViewModel(color: .categoryDefault3, isCorrect: true, question: "This would be the eighth question."),
        QuestionViewModel(color: .categoryDefault4, isCorrect: false, question: "This would be the ninth question."),
        QuestionViewModel(color: .categoryDefault5, isCorrect: false, question: "This would be the tenth question."),
    ]
}
