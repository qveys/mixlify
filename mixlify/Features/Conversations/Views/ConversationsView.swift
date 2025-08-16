import SwiftUI
import os

struct ConversationsView: View {
    @StateObject private var viewModel = ConversationsViewModel()
    @State private var selectedConversation: Conversation?
    @State private var columnVisibility = NavigationSplitViewVisibility.all
    private let logger = Logger(subsystem: "com.mixlify", category: "ConversationsView")
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            Group {
                if viewModel.isLoading {
                    ProgressView("Chargement des conversations...")
                        .onAppear {
                            logger.debug("Showing loading indicator")
                        }
                } else if let error = viewModel.error {
                    VStack {
                        Text("Erreur de chargement")
                            .foregroundColor(.red)
                        Text(error.localizedDescription)
                            .font(.caption)
                        Button("Réessayer") {
                            logger.debug("Retrying conversation load")
                            Task {
                                await viewModel.loadConversations()
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                    .onAppear {
                        logger.error("Showing error: \(error.localizedDescription)")
                    }
                } else if viewModel.conversations.isEmpty {
                    ContentUnavailableView {
                        Label("Aucune conversation", systemImage: "message")
                    } description: {
                        Text("Commencez une nouvelle conversation")
                    }
                } else {
                    List(viewModel.conversations, selection: $selectedConversation) { conversation in
                        ConversationRow(conversation: conversation)
                            .tag(conversation)
                    }
                    .refreshable {
                        logger.debug("Manual refresh triggered")
                        await viewModel.loadConversations()
                    }
                }
            }
            .navigationTitle("Conversations")
            .frame(minWidth: 250)
        } detail: {
            if let conversation = selectedConversation {
                ChatView(conversation: conversation)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ContentUnavailableView {
                    Label("Sélectionnez une conversation", systemImage: "bubble.left.and.bubble.right")
                } description: {
                    Text("Choisissez une conversation dans la liste")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .task {
            logger.debug("ConversationsView task started")
            await viewModel.loadConversations()
        }
    }
} 