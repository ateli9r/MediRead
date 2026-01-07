//
//  ContentView.swift
//  MediRead
//
//  Created by 이현탁 on 1/7/26.
//

/*
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
*/

import SwiftUI

struct ContentView: View {
    @State private var isReading = false
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            Color(hex: "#F5F1E8")
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                Text("독서하는 시간")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(Color(hex: "#4A5D4F"))
                
                Text(timeString(from: elapsedTime))
                    .font(.system(size: 64, weight: .light))
                    .foregroundColor(Color(hex: "#4A5D4F"))
                    .monospacedDigit()
                
                Button(action: toggleReading) {
                    Text(isReading ? "종료" : "시작")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 200, height: 60)
                        .background(Color(hex: "#4A5D4F"))
                        .cornerRadius(30)
                }
                
                Spacer()
            }
        }
    }
    
    func toggleReading() {
        if isReading {
            stopTimer()
            elapsedTime = 0
        } else {
            startTimer()
        }
        isReading.toggle()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            elapsedTime += 1
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func timeString(from timeInterval: TimeInterval) -> String {
        let h = Int(timeInterval) / 3600
        let m = Int(timeInterval) / 60 % 60
        let s = Int(timeInterval) % 60
        return String(format: "%02d:%02d:%02d", h, m, s)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 7 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255,
        )
    }
}

#Preview {
    ContentView()
}
