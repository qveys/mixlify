import Foundation
import os

protocol ConversationsServiceProtocol {
    func fetchConversations() async throws -> [Conversation]
}

class ConversationsService: ConversationsServiceProtocol {
    private let logger = Logger(subsystem: "com.mixlify", category: "ConversationsService")
    
    func fetchConversations() async throws -> [Conversation] {
        logger.debug("Starting fetchConversations")
        
        do {
            // Simulate network delay
            logger.debug("Simulating network delay...")
            try await Task.sleep(nanoseconds: 1_000_000_000)
            
            // Return mock conversations
            logger.debug("Loading mock conversations...")
            let mockConversations = Conversation.mockConversations
            logger.debug("Successfully loaded \(mockConversations.count) conversations")
            
            if mockConversations.isEmpty {
                logger.warning("Warning: No mock conversations were loaded")
            } else {
                for (index, conversation) in mockConversations.enumerated() {
                    logger.debug("Conversation \(index + 1): \(conversation.title) with \(conversation.messages.count) messages")
                }
            }
            
            return mockConversations
        } catch {
            logger.error("Error in fetchConversations: \(error.localizedDescription)")
            throw error
        }
    }
} 