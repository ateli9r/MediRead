//
//  ContentView.swift
//  MediRead
//
//  Created by 이현탁 on 1/7/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TimerView()
                .tabItem {
                    Image(systemName: "timer")
                    Text("타이머")
                }
            
            HistoryView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("히스토리")
                }
        }
    }
}

#Preview {
    ContentView()
}
