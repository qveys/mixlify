import Foundation

enum MessagePlatform: Equatable {
    case whatsapp
    case messenger
    case instagram
    case iMessage
    case sms
    case twitter
    case telegram
    
    var displayName: String {
        switch self {
        case .whatsapp: return "WhatsApp"
        case .messenger: return "Messenger"
        case .instagram: return "Instagram"
        case .iMessage: return "iMessage"
        case .sms: return "SMS"
        case .twitter: return "Twitter"
        case .telegram: return "Telegram"
        }
    }
}

struct Contact: Identifiable, Hashable {
    let id: UUID
    var name: String
    var avatar: URL?
    var platforms: Set<MessagePlatform>
    var unifiedIdentifier: String // Identifiant unique pour regrouper les contacts multi-plateformes
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Message: Identifiable, Equatable {
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

struct Attachment: Identifiable, Equatable {
    let id: UUID
    var url: URL
    var type: AttachmentType
    var previewImage: URL?
    
    static func == (lhs: Attachment, rhs: Attachment) -> Bool {
        lhs.id == rhs.id &&
        lhs.url == rhs.url &&
        lhs.type == rhs.type &&
        lhs.previewImage == rhs.previewImage
    }
}

enum AttachmentType: Equatable {
    case image
    case video
    case audio
    case document
    case location
}

struct Conversation: Identifiable, Hashable {
    let id: UUID
    var contact: Contact
    var lastMessage: Message?
    var messages: [Message]
    var unreadCount: Int
    var isPinned: Bool
    var isMuted: Bool
    var platforms: Set<MessagePlatform>
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Conversation, rhs: Conversation) -> Bool {
        lhs.id == rhs.id
    }
} 