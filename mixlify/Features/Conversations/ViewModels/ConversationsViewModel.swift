import Foundation
import os

@MainActor
class ConversationsViewModel: ObservableObject {
    @Published private(set) var conversations: [Conversation] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    private let service: ConversationsServiceProtocol
    private let logger = Logger(subsystem: "com.mixlify", category: "ConversationsViewModel")
    
    init(service: ConversationsServiceProtocol = ConversationsService()) {
        self.service = service
        logger.debug("ConversationsViewModel initialized with service: \(String(describing: type(of: service)))")
    }
    
    func loadConversations() async {
        guard !isLoading else {
            logger.debug("Skipping load - already in progress")
            return
        }
        
        logger.debug("Starting to load conversations")
        isLoading = true
        error = nil
        
        do {
            logger.debug("Fetching conversations from service")
            let loadedConversations = try await service.fetchConversations()
            logger.debug("Successfully loaded \(loadedConversations.count) conversations")
            
            self.conversations = loadedConversations.sorted { conv1, conv2 in
                if conv1.isPinned != conv2.isPinned {
                    return conv1.isPinned
                }
                return conv1.lastMessage?.timestamp ?? Date.distantPast > 
                       conv2.lastMessage?.timestamp ?? Date.distantPast
            }
            
            self.isLoading = false
            self.error = nil
            
            logger.debug("Conversations sorted and updated in ViewModel")
        } catch {
            logger.error("Failed to load conversations: \(error.localizedDescription)")
            self.error = error
            self.isLoading = false
        }
    }
} 