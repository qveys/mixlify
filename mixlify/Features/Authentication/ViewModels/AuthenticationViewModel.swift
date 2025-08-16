import Foundation
import Combine

final class AuthenticationViewModel: ObservableObject {
    enum State: Equatable {
        case idle
        case authenticating
        case authenticated
        case error(String)
    }
    
    enum Action {
        case signIn(email: String, password: String)
        case signUp(displayName: String, email: String, password: String)
        case signOut
        case resetPassword(email: String)
    }
    
    @Published private(set) var state: State = .idle
    @Published private(set) var currentUser: User?
    
    private let authService: AuthServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
        
        // Vérifier si l'utilisateur est déjà connecté
        if authService.isAuthenticated {
            self.state = .authenticated
            self.currentUser = authService.currentUser
        }
    }
    
    func dispatch(_ action: Action) {
        switch action {
        case let .signIn(email, password):
            state = .authenticating
            
            authService.signIn(email: email, password: password)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.state = .error(error.localizedDescription)
                    }
                } receiveValue: { [weak self] user in
                    self?.currentUser = user
                    self?.state = .authenticated
                }
                .store(in: &cancellables)
            
        case let .signUp(displayName, email, password):
            state = .authenticating
            
            authService.signUp(email: email, password: password, displayName: displayName)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.state = .error(error.localizedDescription)
                    }
                } receiveValue: { [weak self] user in
                    self?.currentUser = user
                    self?.state = .authenticated
                }
                .store(in: &cancellables)
            
        case .signOut:
            state = .authenticating
            
            authService.signOut()
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.state = .error(error.localizedDescription)
                    }
                } receiveValue: { [weak self] _ in
                    self?.currentUser = nil
                    self?.state = .idle
                }
                .store(in: &cancellables)
            
        case let .resetPassword(email):
            state = .authenticating
            
            authService.resetPassword(email: email)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.state = .error(error.localizedDescription)
                    } else {
                        self?.state = .idle
                    }
                } receiveValue: { _ in }
                .store(in: &cancellables)
        }
    }
} 