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
    static let mockMessages: [Message] = {
        let alice = Contact.mockContacts[0]
        let thomas = Contact.mockContacts[1]
        let sophie = Contact.mockContacts[2]
        let lucas = Contact.mockContacts[3]
        let currentUser = Contact(id: UUID(), name: "Moi", platforms: [.messenger, .whatsapp, .telegram], unifiedIdentifier: "me")
        
        let now = Date()
        
        let aliceMessages: [Message] = [
            Message(
                id: UUID(),
                content: "Quoi de prévu de ton dimanche ?",
                timestamp: now.addingTimeInterval(-3600 * 3),
                platform: .messenger,
                sender: alice,
                recipient: currentUser,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "Je suis chez moi dans le lit à regarder des séries tranquille",
                timestamp: now.addingTimeInterval(-3600 * 2),
                platform: .messenger,
                sender: currentUser,
                recipient: alice,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "À poile évidemment et deux trois branlettes au passage 😅",
                timestamp: now.addingTimeInterval(-3600 * 2 + 120),
                platform: .messenger,
                sender: currentUser,
                recipient: alice,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "Et toi?",
                timestamp: now.addingTimeInterval(-3600 * 2 + 180),
                platform: .messenger,
                sender: currentUser,
                recipient: alice,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "Je suis aussi chez moi devant « reportages »",
                timestamp: now.addingTimeInterval(-3600),
                platform: .messenger,
                sender: alice,
                recipient: currentUser,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "Un vrai dimanche chez papie mamie à faire la sieste",
                timestamp: now.addingTimeInterval(-3600 + 60),
                platform: .messenger,
                sender: alice,
                recipient: currentUser,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "Haha sauf que toi c'est pour une bonne raison, t'as travaillé dur 😉",
                timestamp: now.addingTimeInterval(-1800),
                platform: .messenger,
                sender: currentUser,
                recipient: alice,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "lol , c'est pas si dur que ça de servir !",
                timestamp: now.addingTimeInterval(-1200),
                platform: .messenger,
                sender: alice,
                recipient: currentUser,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "Plus je t'avoue profiter bien plus de la démence comme ça",
                timestamp: now.addingTimeInterval(-1180),
                platform: .messenger,
                sender: alice,
                recipient: currentUser,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "Ha bon? Comment?",
                timestamp: now.addingTimeInterval(-900),
                platform: .messenger,
                sender: currentUser,
                recipient: alice,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "Bah , je paye pas mon entrée , je gagne de l'argent",
                timestamp: now.addingTimeInterval(-600),
                platform: .messenger,
                sender: alice,
                recipient: currentUser,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "Je peux danser",
                timestamp: now.addingTimeInterval(-580),
                platform: .messenger,
                sender: alice,
                recipient: currentUser,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "Tout est cool",
                timestamp: now.addingTimeInterval(-560),
                platform: .messenger,
                sender: alice,
                recipient: currentUser,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "Oui c'est vrai que vu comme ça, mais bon y a du travail derrière quand même 😌",
                timestamp: now.addingTimeInterval(-300),
                platform: .messenger,
                sender: currentUser,
                recipient: alice,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "Faut être courageux pour faire ça jusque pas d'heures quand même",
                timestamp: now.addingTimeInterval(-60),
                platform: .messenger,
                sender: currentUser,
                recipient: alice,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "C'est pas une question de courage van",
                timestamp: now,
                platform: .messenger,
                sender: alice,
                recipient: currentUser,
                isRead: false,
                attachments: []
            )
        ]

        let thomasMessages: [Message] = [
            Message(
                id: UUID(),
                content: "J'ai ajouté les photos de la soirée dans un album",
                timestamp: now.addingTimeInterval(-86400),
                platform: .whatsapp,
                sender: thomas,
                recipient: currentUser,
                isRead: true,
                attachments: [
                    Attachment(id: UUID(), url: URL(string: "https://example.com/party1.jpg")!, type: .image),
                    Attachment(id: UUID(), url: URL(string: "https://example.com/party2.jpg")!, type: .image)
                ]
            ),
            Message(
                id: UUID(),
                content: "Merci ! Les photos sont superbes 📸",
                timestamp: now.addingTimeInterval(-86000),
                platform: .whatsapp,
                sender: currentUser,
                recipient: thomas,
                isRead: true,
                attachments: []
            )
        ]

        let sophieMessages: [Message] = [
            Message(
                id: UUID(),
                content: "Hey! Tu viens à l'expo ce weekend ?",
                timestamp: now.addingTimeInterval(-172800),
                platform: .messenger,
                sender: sophie,
                recipient: currentUser,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "Oui, j'ai vraiment hâte de voir les nouvelles œuvres ! 🎨",
                timestamp: now.addingTimeInterval(-172500),
                platform: .messenger,
                sender: currentUser,
                recipient: sophie,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "Super ! On pourrait se retrouver devant la galerie vers 14h ?",
                timestamp: now.addingTimeInterval(-172200),
                platform: .messenger,
                sender: sophie,
                recipient: currentUser,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "Parfait pour moi ! À samedi alors 😊",
                timestamp: now.addingTimeInterval(-172000),
                platform: .messenger,
                sender: currentUser,
                recipient: sophie,
                isRead: true,
                attachments: []
            )
        ]

        let lucasMessages: [Message] = [
            Message(
                id: UUID(),
                content: "T'as regardé le dernier épisode de la série ?",
                timestamp: now.addingTimeInterval(-7200),
                platform: .whatsapp,
                sender: lucas,
                recipient: currentUser,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "Pas encore, mais ne me spoile pas ! 🙈",
                timestamp: now.addingTimeInterval(-7000),
                platform: .whatsapp,
                sender: currentUser,
                recipient: lucas,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "T'inquiète ! Mais dépêche-toi de le regarder, il est vraiment incroyable 🤯",
                timestamp: now.addingTimeInterval(-6800),
                platform: .whatsapp,
                sender: lucas,
                recipient: currentUser,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "Je le regarde ce soir sans faute !",
                timestamp: now.addingTimeInterval(-6600),
                platform: .whatsapp,
                sender: currentUser,
                recipient: lucas,
                isRead: true,
                attachments: []
            ),
            Message(
                id: UUID(),
                content: "On en discute demain alors ! 🍿",
                timestamp: now.addingTimeInterval(-6400),
                platform: .whatsapp,
                sender: lucas,
                recipient: currentUser,
                isRead: false,
                attachments: []
            )
        ]

        return aliceMessages + thomasMessages + sophieMessages + lucasMessages
    }()
}

extension Conversation {
    static let mockConversations = {
        let allMessages = Message.mockMessages
        
        // Filtrer les messages pour chaque contact
        let aliceMessages = allMessages.filter { msg in
            msg.sender.unifiedIdentifier == "alice.martin" || 
            (msg.recipient.unifiedIdentifier == "alice.martin" && msg.sender.unifiedIdentifier == "me")
        }
        
        let thomasMessages = allMessages.filter { msg in
            msg.sender.unifiedIdentifier == "thomas.dubois" || 
            (msg.recipient.unifiedIdentifier == "thomas.dubois" && msg.sender.unifiedIdentifier == "me")
        }
        
        let sophieMessages = allMessages.filter { msg in
            msg.sender.unifiedIdentifier == "sophie.bernard" || 
            (msg.recipient.unifiedIdentifier == "sophie.bernard" && msg.sender.unifiedIdentifier == "me")
        }
        
        let lucasMessages = allMessages.filter { msg in
            msg.sender.unifiedIdentifier == "lucas.petit" || 
            (msg.recipient.unifiedIdentifier == "lucas.petit" && msg.sender.unifiedIdentifier == "me")
        }
        
        return [
            Conversation(id: UUID(),
                        contact: Contact.mockContacts[0],
                        lastMessage: aliceMessages.last,
                        messages: aliceMessages,
                        unreadCount: aliceMessages.filter { !$0.isRead }.count,
                        isPinned: true,
                        isMuted: false,
                        platforms: [.whatsapp, .messenger]),
            
            Conversation(id: UUID(),
                        contact: Contact.mockContacts[1],
                        lastMessage: thomasMessages.last,
                        messages: thomasMessages,
                        unreadCount: thomasMessages.filter { !$0.isRead }.count,
                        isPinned: false,
                        isMuted: false,
                        platforms: [.whatsapp, .telegram, .iMessage]),
            
            Conversation(id: UUID(),
                        contact: Contact.mockContacts[2],
                        lastMessage: sophieMessages.last,
                        messages: sophieMessages,
                        unreadCount: sophieMessages.filter { !$0.isRead }.count,
                        isPinned: false,
                        isMuted: true,
                        platforms: [.messenger, .instagram]),
            
            Conversation(id: UUID(),
                        contact: Contact.mockContacts[3],
                        lastMessage: lucasMessages.last,
                        messages: lucasMessages,
                        unreadCount: lucasMessages.filter { !$0.isRead }.count,
                        isPinned: false,
                        isMuted: false,
                        platforms: [.whatsapp, .messenger, .instagram])
        ]
    }()
} 