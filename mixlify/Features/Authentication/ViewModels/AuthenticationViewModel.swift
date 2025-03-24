import Foundation
import Combine

final class AuthenticationViewModel: ViewModelProtocol {
    @Published private(set) var state: AuthenticationState = .idle
    private var cancellables = Set<AnyCancellable>()
    
    @Injected(\.authService) private var authService
    
    enum Action {
        case signIn(email: String, password: String)
        case signUp(email: String, password: String, displayName: String)
        case signOut
        case resetPassword(email: String)
    }
    
    func dispatch(_ action: Any) {
        guard let action = action as? Action else { return }
        
        switch action {
        case let .signIn(email, password):
            handleSignIn(email: email, password: password)
        case let .signUp(email, password, displayName):
            handleSignUp(email: email, password: password, displayName: displayName)
        case .signOut:
            handleSignOut()
        case let .resetPassword(email):
            handleResetPassword(email: email)
        }
    }
    
    private func handleSignIn(email: String, password: String) {
        state = .authenticating
        authService.signIn(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.state = .error(error.localizedDescription)
                    }
                },
                receiveValue: { [weak self] user in
                    self?.state = .authenticated(user)
                }
            )
            .store(in: &cancellables)
    }
    
    private func handleSignUp(email: String, password: String, displayName: String) {
        state = .authenticating
        authService.signUp(email: email, password: password, displayName: displayName)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.state = .error(error.localizedDescription)
                    }
                },
                receiveValue: { [weak self] user in
                    self?.state = .authenticated(user)
                }
            )
            .store(in: &cancellables)
    }
    
    private func handleSignOut() {
        authService.signOut()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.state = .error(error.localizedDescription)
                    }
                },
                receiveValue: { [weak self] _ in
                    self?.state = .idle
                }
            )
            .store(in: &cancellables)
    }
    
    private func handleResetPassword(email: String) {
        authService.resetPassword(email: email)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.state = .error(error.localizedDescription)
                    }
                },
                receiveValue: { _ in }
            )
            .store(in: &cancellables)
    }
} 