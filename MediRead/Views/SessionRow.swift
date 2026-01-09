//
//  SessionRow.swift
//  MediRead
//
//  Created by 이현탁 on 1/9/26.
//

import SwiftUI

struct SessionRow: View {
    let session: ReadSession
    
    private let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .short
        f.timeStyle = .short
        return f
    }()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(dateFormatter.string(from: session.startTime))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text("\(session.durationMinutes)분")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 6)
        .contentShape(Rectangle())
    }
}
