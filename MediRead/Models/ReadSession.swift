//
//  ReadSession.swift
//  MediRead
//
//  Created by 이현탁 on 1/9/26.
//

import Foundation
import SwiftData

@Model
final class ReadSession: Identifiable {
    var startTime: Date
    var endTime: Date
    
    var duration: TimeInterval {
        endTime.timeIntervalSince(startTime)
    }
    
    init(startTime: Date, endTime: Date) {
        self.startTime = startTime
        self.endTime = endTime
    }
    
    var durationMinutes: Int { Int(duration / 60) }
    
    var formattedDate: String {
        DateFormatter.localizedString(from: startTime,
                                      dateStyle: .medium,
                                      timeStyle: .short)
    }
}
