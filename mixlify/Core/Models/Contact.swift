import Foundation

struct Contact: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var avatar: URL?
    var platforms: Set<MessagePlatform>
    var unifiedIdentifier: String // Identifiant unique pour regrouper les contacts multi-plateformes
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
} 