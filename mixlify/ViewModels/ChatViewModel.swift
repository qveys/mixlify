import Foundation
import Combine

final class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var showAttachmentPicker = false
    @Published var showContactDetails = false
    @Published var showDeleteAlert = false
    @Published var error: String?
    
    private let conversation: Conversation
    private let interactor: ConversationInteractorProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(conversation: Conversation, interactor: ConversationInteractorProtocol = ConversationInteractor()) {
        self.conversation = conversation
        self.interactor = interactor
        self.messages = conversation.messages
        
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        // Add any necessary subscriptions here
    }
    
    func send(_ text: String) {
        interactor.sendMessage(text, in: conversation)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] message in
                self?.messages.append(message)
            }
            .store(in: &cancellables)
    }
    
    func muteConversation() {
        interactor.muteConversation(conversation)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    func deleteConversation() {
        interactor.deleteConversation(conversation)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    func addAttachment(_ url: URL, type: AttachmentType) {
        // TODO: Implement attachment handling through interactor
    }
} 