import Foundation

struct User: Identifiable, Codable, Equatable {
    let id: UUID
    var email: String
    var name: String
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
} 