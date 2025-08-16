import SwiftUI

@MainActor
class AuthenticationManager: ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    
    init() {
        // TODO: Load user from persistent storage if available
    }
    
    func signIn(email: String, password: String) async throws {
        // TODO: Implement actual authentication
        currentUser = User(
            id: UUID(),
            email: email,
            name: "Test User"
        )
        isAuthenticated = true
    }
    
    func signOut() {
        currentUser = nil
        isAuthenticated = false
    }
} 