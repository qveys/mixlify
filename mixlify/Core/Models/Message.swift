import Foundation

struct Message: Identifiable, Codable, Equatable {
    let id: UUID
    var content: String
    var timestamp: Date
    var platform: MessagePlatform
    var sender: Contact
    var recipient: Contact
    var isRead: Bool
    var attachments: [Attachment]
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id &&
        lhs.content == rhs.content &&
        lhs.timestamp == rhs.timestamp &&
        lhs.platform == rhs.platform &&
        lhs.sender == rhs.sender &&
        lhs.recipient == rhs.recipient &&
        lhs.isRead == rhs.isRead &&
        lhs.attachments == rhs.attachments
    }
} 