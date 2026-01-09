//
//  HistoryView.swift
//  MediRead
//
//  Created by 이현탁 on 1/9/26.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query(sort: \ReadSession.startTime, order: .reverse)
    private var sessions: [ReadSession]
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationStack {
            Group {
                if sessions.isEmpty {
                    emptyStateView
                } else {
                    listView
                }
            }
        }
        .navigationTitle("읽은 기록")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("초기화") {
                    confirmReset()
                }
                .tint(.red)
            }
        }
    }
    
    private var listView: some View {
        List {
            Section(header: Text("최근 7일")) {
                HStack {
                    Text("총 독서 시간")
                    Spacer()
                    Text("\(weeklyTotalMinutes)분")
                        .fontWeight(.semibold)
                }
            }
            
            ForEach(sessions) { session in
                NavigationLink(value: session) {
                    SessionRow(session: session)
                }
            }
            .onDelete(perform: delete)
        }
        .listStyle(.plain)
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 12) {
            Image(systemName: "tray")
                .font(.system(size: 48))
                .foregroundColor(.gray.opacity(0.6))
            
            Text("아직 독서 기록이 없습니다.")
                .font(.headline)
                .foregroundColor(.gray)
        }
        .padding(.top, 60)
    }
    
    private var weeklyTotalMinutes: Int {
        let now = Date()
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: now)!
        
        return sessions
            .filter { $0.startTime >= sevenDaysAgo }
            .reduce(0) { $0 + $1.durationMinutes }
    }
    
    private func delete(at offsets: IndexSet) {
        offsets.map { sessions[$0] }.forEach { session in
            context.delete(session)
        }
    }
    
    private func confirmReset() {
        guard !sessions.isEmpty else { return }
        for session in sessions {
            context.delete(session)
        }
    }
}
