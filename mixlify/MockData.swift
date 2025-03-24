import Foundation

// MARK: - Mock Data
extension Contact {
    static let mockContacts = [
        Contact(id: UUID(), name: "Alice Martin", 
               avatar: URL(string: "https://randomuser.me/api/portraits/women/1.jpg"), 
               platforms: [.whatsapp, .messenger], 
               unifiedIdentifier: "alice.martin"),
        Contact(id: UUID(), name: "Thomas Dubois", 
               avatar: URL(string: "https://randomuser.me/api/portraits/men/2.jpg"), 
               platforms: [.whatsapp, .telegram, .iMessage], 
               unifiedIdentifier: "thomas.dubois"),
        Contact(id: UUID(), name: "Sophie Bernard", 
               avatar: URL(string: "https://randomuser.me/api/portraits/women/3.jpg"), 
               platforms: [.messenger, .instagram], 
               unifiedIdentifier: "sophie.bernard"),
        Contact(id: UUID(), name: "Lucas Petit", 
               avatar: URL(string: "https://randomuser.me/api/portraits/men/4.jpg"), 
               platforms: [.whatsapp, .messenger, .instagram], 
               unifiedIdentifier: "lucas.petit")
    ]
}

extension Message {
    static let mockMessages = [
        Message(id: UUID(), 
                content: "Salut ! On se retrouve où pour le déjeuner ?", 
                timestamp: Date().addingTimeInterval(-3600), 
                platform: .whatsapp,
                sender: Contact.mockContacts[0],
                recipient: Contact.mockContacts[1],
                isRead: true,
                attachments: []),
        Message(id: UUID(), 
                content: "J'ai partagé les photos de la soirée 📸", 
                timestamp: Date().addingTimeInterval(-7200), 
                platform: .messenger,
                sender: Contact.mockContacts[2],
                recipient: Contact.mockContacts[0],
                isRead: false,
                attachments: [])
    ]
}

extension Conversation {
    static let mockConversations = [
        Conversation(id: UUID(),
                    contact: Contact.mockContacts[0],
                    lastMessage: Message.mockMessages[0],
                    unreadCount: 2,
                    isPinned: true,
                    isMuted: false,
                    platforms: [.whatsapp, .messenger]),
        Conversation(id: UUID(),
                    contact: Contact.mockContacts[1],
                    lastMessage: nil,
                    unreadCount: 0,
                    isPinned: false,
                    isMuted: false,
                    platforms: [.whatsapp, .telegram, .iMessage]),
        Conversation(id: UUID(),
                    contact: Contact.mockContacts[2],
                    lastMessage: Message.mockMessages[1],
                    unreadCount: 1,
                    isPinned: false,
                    isMuted: true,
                    platforms: [.messenger, .instagram]),
        Conversation(id: UUID(),
                    contact: Contact.mockContacts[3],
                    lastMessage: nil,
                    unreadCount: 0,
                    isPinned: false,
                    isMuted: false,
                    platforms: [.whatsapp, .messenger, .instagram])
    ]
} 