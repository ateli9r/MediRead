//
//  ReadingSession.swift
//  MediRead
//
//  Created by 이현탁 on 1/7/26.
//

import Foundation
import SwiftData

@Model
final class ReadingSession {
    var startTime: Date
    var endTime: Date
    var duration: TimeInterval
    
    init(startTime: Date, endTime: Date) {
        self.startTime = startTime
        self.endTime = endTime
        self.duration = endTime.timeIntervalSince(startTime)
    }
    
    var durationInMinutes: Int { Int(duration / 60) }
}
