import SwiftUI
import os

struct ContentView: View {
    @AppStorage("isAuthenticated") private var isAuthenticated = false
    private let logger = Logger(subsystem: "com.mixlify", category: "ContentView")
    
    var body: some View {
        Group {
            if isAuthenticated {
                ConversationsView()
                    .onAppear {
                        logger.debug("ConversationsView appeared")
                    }
            } else {
                AuthenticationView()
                    .onAppear {
                        logger.debug("AuthenticationView appeared")
                    }
            }
        }
        .onChange(of: isAuthenticated) { newValue in
            logger.debug("Authentication state changed to: \(newValue)")
        }
    }
}

#Preview {
    ContentView()
} 