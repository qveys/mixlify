import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var showAttachmentPicker = false
    @Published var showContactDetails = false
    @Published var showDeleteAlert = false
    
    private let conversation: Conversation
    private var cancellables = Set<AnyCancellable>()
    
    init(conversation: Conversation) {
        self.conversation = conversation
        self.messages = conversation.messages
    }
    
    func send(_ text: String) {
        let newMessage = Message(
            id: UUID(),
            content: text,
            timestamp: Date(),
            platform: conversation.platforms.first ?? .messenger,
            sender: Contact(id: UUID(), name: "Moi", platforms: conversation.platforms, unifiedIdentifier: "me"),
            recipient: conversation.contact,
            isRead: true,
            attachments: []
        )
        messages.append(newMessage)
        // TODO: Implémenter l'envoi réel du message via l'API appropriée
    }
    
    func muteConversation() {
        // TODO: Implémenter la mise en sourdine
    }
    
    func deleteConversation() {
        // TODO: Implémenter la suppression de la conversation
    }
    
    func addAttachment(_ url: URL, type: AttachmentType) {
        // TODO: Implémenter l'ajout de pièces jointes
    }
} 