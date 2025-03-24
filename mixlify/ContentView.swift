//
//  ContentView.swift
//  mixlify
//
//  Created by Quentin VEYS on 24/03/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ConversationListView()
                .navigationTitle("Messages")
        }
    }
}

#Preview {
    ContentView()
}
