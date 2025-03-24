import Foundation

public struct User: Identifiable, Codable, Equatable {
    public let id: String
    public var email: String
    public var displayName: String
    public var profileImageURL: URL?
    public var createdAt: Date
    public var updatedAt: Date
    
    public init(
        id: String,
        email: String,
        displayName: String,
        profileImageURL: URL? = nil,
        createdAt: Date,
        updatedAt: Date
    ) {
        self.id = id
        self.email = email
        self.displayName = displayName
        self.profileImageURL = profileImageURL
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    public var initials: String {
        displayName.components(separatedBy: " ")
            .compactMap { $0.first }
            .prefix(2)
            .map(String.init)
            .joined()
    }
} 