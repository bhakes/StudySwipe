//
//  TestObservationViewModel.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 8/3/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation

class TestObservationViewModel {

    static var timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        return formatter
    }()

    var testObservation: InterviewTestObservation

    var duration: String {
        var durationString: String?
        if let startTime = testObservation.startTimestamp, let finishTime = testObservation.finishTimestamp {
            let duration = DateInterval(start: startTime, end: finishTime).duration
            durationString = TestObservationViewModel.timeFormatter.string(from: duration)
        }
        return [testObservation.title, durationString].compactMap{$0}.joined(separator: " – ")
    }

    init (interviewTestObservation: InterviewTestObservation) {
        self.testObservation = interviewTestObservation
    }
}
