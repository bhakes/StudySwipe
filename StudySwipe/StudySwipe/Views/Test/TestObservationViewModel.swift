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

    struct CategoryViewModel {
        let color: UIColor
        let total: Int
        let correct: Int
        let title: String
    }

    init (interviewTestObservation: InterviewTestObservation) {
        self.testObservation = interviewTestObservation
    }

    private func summarizeCategories() -> [CategoryViewModel] {
        guard let questionObservations = testObservation.questionObservation?.array as? Array<QuestionObservation> else { return [] }
        let questions = questionObservations.compactMap { $0.question }
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
}
