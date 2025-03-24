import SwiftUI

struct ConversationListView: View {
    @StateObject private var viewModel = ConversationListViewModel()
    @State private var searchText = ""
    
    var body: some View {
        List {
            ForEach(filteredConversations) { conversation in
                NavigationLink(value: conversation) {
                    ConversationRow(conversation: conversation)
                }
            }
        }
        .searchable(text: $searchText, prompt: "Rechercher")
        .toolbar {
            ToolbarItemGroup {
                Button(action: { viewModel.showNewMessageSheet = true }) {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .navigationDestination(for: Conversation.self) { conversation in
            ChatView(conversation: conversation)
        }
    }
    
    private var filteredConversations: [Conversation] {
        if searchText.isEmpty {
            return viewModel.conversations
        }
        return viewModel.conversations.filter { conversation in
            conversation.contact.name.localizedCaseInsensitiveContains(searchText)
        }
    }
}

struct ConversationRow: View {
    let conversation: Conversation
    
    var body: some View {
        HStack(spacing: 12) {
            // Avatar
            AsyncImage(url: conversation.contact.avatar) { image in
                image.resizable()
            } placeholder: {
                Image(systemName: "person.circle.fill")
                    .foregroundColor(.gray)
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            // Info
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(conversation.contact.name)
                        .font(.headline)
                    
                    Spacer()
                    
                    if let lastMessage = conversation.lastMessage {
                        Text(lastMessage.timestamp, style: .time)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                HStack {
                    // Platform indicators
                    HStack(spacing: 4) {
                        ForEach(Array(conversation.platforms), id: \.self) { platform in
                            PlatformIndicator(platform: platform)
                        }
                    }
                    
                    if let lastMessage = conversation.lastMessage {
                        Text(lastMessage.content)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                }
            }
            
            // Unread count badge
            if conversation.unreadCount > 0 {
                Spacer()
                
                Text("\(conversation.unreadCount)")
                    .font(.caption2)
                    .padding(6)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
        }
        .padding(.vertical, 8)
    }
}

struct PlatformIndicator: View {
    let platform: MessagePlatform
    
    var body: some View {
        Image(systemName: iconName)
            .foregroundColor(iconColor)
            .font(.caption2)
    }
    
    private var iconName: String {
        switch platform {
        case .whatsapp: return "message.circle.fill"
        case .messenger: return "bolt.circle.fill"
        case .instagram: return "camera.circle.fill"
        case .iMessage: return "bubble.left.fill"
        case .sms: return "message.fill"
        case .twitter: return "bird.fill"
        case .telegram: return "paperplane.circle.fill"
        }
    }
    
    private var iconColor: Color {
        switch platform {
        case .whatsapp: return .green
        case .messenger: return .blue
        case .instagram: return .purple
        case .iMessage: return .blue
        case .sms: return .gray
        case .twitter: return .blue
        case .telegram: return .blue
        }
    }
} 