//
//  stopwatch.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/8/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation

protocol StopwatchDelegate: class {
    func stopwatch(_ stopwatch: Stopwatch, didChangeTimeTo: TimeInterval)
}

class Stopwatch {
    
    weak var delegate: StopwatchDelegate?
    
    var formattedTime: String {
        return Stopwatch.timeFormatter.string(from: timeCount) ?? "0:00"
    }
    
    private var timer: Timer?
    private let countUp: Bool
    private var timeCount: TimeInterval {
        didSet { notifyDelegate() }
    }
    
    init(timeCount: TimeInterval = 0, countUp: Bool = true) {
        self.timeCount = timeCount
        self.countUp = countUp
    }
    
    deinit {
        stop()
    }
    
    func start() {
        pause()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            guard let unwrappedSelf = self else { return }
            if unwrappedSelf.countUp {
                unwrappedSelf.timeCount += 1
            } else {
                unwrappedSelf.timeCount -= 1
            }
        })
        notifyDelegate()
    }
    
    func pause() {
        timer?.invalidate()
        timer = nil
    }
    
    func stop() {
        pause()
        timeCount = 0
    }
    
    private func notifyDelegate() {
        delegate?.stopwatch(self, didChangeTimeTo: timeCount)
    }
    
    static var timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        return formatter
    }()
    
}
