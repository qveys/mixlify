import SwiftUI

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

struct ChatView: View {
    let conversation: Conversation
    @StateObject private var viewModel: ChatViewModel
    @State private var messageText = ""
    @FocusState private var isInputFocused: Bool
    
    init(conversation: Conversation) {
        self.conversation = conversation
        self._viewModel = StateObject(wrappedValue: ChatViewModel(conversation: conversation))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.messages) { message in
                            MessageBubble(message: message)
                                .id(message.id)
                        }
                    }
                    .padding()
                }
                .onChange(of: viewModel.messages) { oldValue, newValue in
                    withAnimation {
                        proxy.scrollTo(newValue.last?.id, anchor: .bottom)
                    }
                }
            }
            
            Divider()
            
            // Zone de saisie
            HStack(spacing: 12) {
                Button(action: { viewModel.showAttachmentPicker = true }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                
                TextField("Message", text: $messageText)
                    .textFieldStyle(.roundedBorder)
                    .focused($isInputFocused)
                
                if !messageText.isEmpty {
                    Button(action: sendMessage) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding()
        }
        #if os(iOS)
        .navigationTitle(conversation.contact.name)
        .navigationBarTitleDisplayMode(.inline)
        #else
        .navigationSubtitle(conversation.contact.name)
        #endif
        .toolbar {
            ToolbarItemGroup {
                Menu {
                    Button(action: { viewModel.showContactDetails = true }) {
                        Label("Infos contact", systemImage: "info.circle")
                    }
                    
                    Button(action: { viewModel.muteConversation() }) {
                        Label(
                            conversation.isMuted ? "Réactiver les notifications" : "Mettre en sourdine",
                            systemImage: conversation.isMuted ? "bell.fill" : "bell.slash.fill"
                        )
                    }
                    
                    Button(role: .destructive, action: { viewModel.showDeleteAlert = true }) {
                        Label("Supprimer la conversation", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
    }
    
    private func sendMessage() {
        guard !messageText.isEmpty else { return }
        viewModel.send(messageText)
        messageText = ""
    }
}

struct MessageBubble: View {
    let message: Message
    
    private var isFromCurrentUser: Bool {
        // TODO: Implémenter la logique pour déterminer si le message vient de l'utilisateur actuel
        return false
    }
    
    var body: some View {
        HStack {
            if isFromCurrentUser { Spacer() }
            
            VStack(alignment: isFromCurrentUser ? .trailing : .leading, spacing: 4) {
                HStack {
                    if !isFromCurrentUser {
                        PlatformIndicator(platform: message.platform)
                            .font(.caption)
                    }
                    
                    Text(message.content)
                        .padding(12)
                        .background(isFromCurrentUser ? Color.blue : backgroundColor)
                        .foregroundColor(isFromCurrentUser ? .white : .primary)
                        .cornerRadius(16)
                    
                    if isFromCurrentUser {
                        PlatformIndicator(platform: message.platform)
                            .font(.caption)
                    }
                }
                
                if !message.attachments.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(message.attachments) { attachment in
                                AttachmentView(attachment: attachment)
                            }
                        }
                    }
                }
                
                Text(message.timestamp, style: .time)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            
            if !isFromCurrentUser { Spacer() }
        }
    }
    
    private var backgroundColor: Color {
        #if os(iOS)
        return Color(uiColor: .systemGray6)
        #elseif os(macOS)
        return Color(nsColor: .windowBackgroundColor)
        #endif
    }
}

struct AttachmentView: View {
    let attachment: Attachment
    
    var body: some View {
        Group {
            switch attachment.type {
            case .image:
                AsyncImage(url: attachment.url) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 200, height: 150)
                .cornerRadius(12)
                
            case .video:
                // TODO: Implémenter la prévisualisation vidéo
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 200, height: 150)
                    .overlay(
                        Image(systemName: "play.circle.fill")
                            .font(.largeTitle)
                    )
                
            case .audio:
                // TODO: Implémenter le lecteur audio
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 200, height: 60)
                    .overlay(
                        Image(systemName: "waveform")
                            .font(.title)
                    )
                
            case .document:
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 200, height: 60)
                    .overlay(
                        Image(systemName: "doc.fill")
                            .font(.title)
                    )
                
            case .location:
                // TODO: Implémenter la prévisualisation de la carte
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 200, height: 150)
                    .overlay(
                        Image(systemName: "map.fill")
                            .font(.largeTitle)
                    )
            }
        }
    }
} 