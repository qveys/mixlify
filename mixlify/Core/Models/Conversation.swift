import Foundation

struct Conversation: Identifiable, Codable, Hashable {
    let id: UUID
    var contact: Contact
    var lastMessage: Message?
    var messages: [Message]
    var unreadCount: Int
    var isPinned: Bool
    var isMuted: Bool
    var platforms: Set<MessagePlatform>
    
    var title: String {
        contact.name
    }
    
    var formattedDate: String {
        guard let date = lastMessage?.timestamp else { return "" }
        return DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .short)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Conversation, rhs: Conversation) -> Bool {
        lhs.id == rhs.id
    }
} 