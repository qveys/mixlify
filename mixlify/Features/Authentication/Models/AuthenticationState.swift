import Foundation

enum AuthenticationState: Equatable {
    case idle
    case authenticating
    case authenticated(User)
    case error(String)
}

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let displayName: String
    let profileImageURL: URL?
    
    var initials: String {
        displayName.components(separatedBy: " ")
            .compactMap { $0.first }
            .prefix(2)
            .map(String.init)
            .joined()
    }
} 