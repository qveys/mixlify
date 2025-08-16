import SwiftUI

struct ConversationDetailView: View {
    let conversation: Conversation
    @State private var messageText = ""
    @EnvironmentObject private var authManager: AuthenticationManager
    
    private func isFromCurrentUser(_ message: Message) -> Bool {
        guard let currentUserId = authManager.currentUser?.id else { return false }
        return message.sender.unifiedIdentifier == currentUserId
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(conversation.messages) { message in
                        MessageBubble(text: message.content, isCurrentUser: isFromCurrentUser(message))
                    }
                }
                .padding()
            }
            
            HStack {
                TextField("Votre message...", text: $messageText)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    // TODO: Send message
                    messageText = ""
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
            }
            .padding()
        }
        .navigationTitle(conversation.title)
    }
}

// Helper view for message bubbles
struct ConversationMessageBubble: View {
    let text: String
    let isCurrentUser: Bool
    
    var body: some View {
        HStack {
            if isCurrentUser { Spacer() }
            
            Text(text)
                .padding(12)
                .background(isCurrentUser ? Color.blue : Color(.systemGray5))
                .foregroundColor(isCurrentUser ? .white : .primary)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            if !isCurrentUser { Spacer() }
        }
    }
} 