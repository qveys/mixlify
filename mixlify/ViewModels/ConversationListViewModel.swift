import Foundation
import Combine

class ConversationListViewModel: ObservableObject {
    @Published var conversations: [Conversation] = []
    @Published var showNewMessageSheet = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadConversations()
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        // Les souscriptions seront implémentées plus tard
    }
    
    func loadConversations() {
        // Utilisation des données de test
        conversations = Conversation.mockConversations
    }
    
    func markAsRead(_ conversation: Conversation) {
        guard let index = conversations.firstIndex(where: { $0.id == conversation.id }) else { return }
        conversations[index].unreadCount = 0
    }
    
    func deleteConversation(_ conversation: Conversation) {
        conversations.removeAll { $0.id == conversation.id }
    }
    
    func pinConversation(_ conversation: Conversation) {
        guard let index = conversations.firstIndex(where: { $0.id == conversation.id }) else { return }
        conversations[index].isPinned.toggle()
        sortConversations()
    }
    
    func muteConversation(_ conversation: Conversation) {
        guard let index = conversations.firstIndex(where: { $0.id == conversation.id }) else { return }
        conversations[index].isMuted.toggle()
    }
    
    private func sortConversations() {
        conversations.sort { conv1, conv2 in
            if conv1.isPinned != conv2.isPinned {
                return conv1.isPinned
            }
            return conv1.lastMessage?.timestamp ?? Date.distantPast > 
                   conv2.lastMessage?.timestamp ?? Date.distantPast
        }
    }
} 