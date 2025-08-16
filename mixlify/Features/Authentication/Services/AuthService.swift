import Foundation
import Combine
import Security

final class AuthService: AuthServiceProtocol {
    var cancellables = Set<AnyCancellable>()
    private(set) var currentUser: User?
    private let keychainService = "com.mixlify.auth"
    private let userDefaults = UserDefaults.standard
    
    // Compte admin temporaire
    private let tempAdminCredentials = (username: "admin", password: "admin")
    
    init() {
        loadPersistedSession()
    }
    
    var isAuthenticated: Bool {
        currentUser != nil
    }
    
    private func loadPersistedSession() {
        if let userData = userDefaults.data(forKey: "currentUser"),
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            self.currentUser = user
        }
    }
    
    private func persistSession(user: User, token: String) {
        // Sauvegarder le token dans le Keychain
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: user.id.uuidString,
            kSecValueData as String: token.data(using: .utf8)!
        ]
        
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            print("Erreur lors de la sauvegarde du token")
            return
        }
        
        // Sauvegarder les informations utilisateur
        if let userData = try? JSONEncoder().encode(user) {
            userDefaults.set(userData, forKey: "currentUser")
        }
        
        self.currentUser = user
    }
    
    private func clearPersistedSession() {
        // Supprimer le token du Keychain
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService
        ]
        SecItemDelete(query as CFDictionary)
        
        // Supprimer les informations utilisateur
        userDefaults.removeObject(forKey: "currentUser")
        self.currentUser = nil
    }
    
    func signIn(email: String, password: String) -> AnyPublisher<User, Error> {
        // Simulation d'une requête API
        return Future<User, Error> { promise in
            let work = DispatchWorkItem {
                // Vérifier les identifiants admin temporaires
                if email == self.tempAdminCredentials.username && password == self.tempAdminCredentials.password {
                    let adminUser = User(
                        id: UUID(),
                        name: "Administrator",
                        email: "admin@mixlify.com"
                    )
                    
                    self.persistSession(user: adminUser, token: "admin-token")
                    promise(.success(adminUser))
                    return
                }
                
                // Validation normale pour les autres utilisateurs
                guard email.contains("@") else {
                    promise(.failure(AuthError.invalidEmail))
                    return
                }
                guard password.count >= 6 else {
                    promise(.failure(AuthError.invalidPassword))
                    return
                }
                
                // Simuler une réponse réussie
                let user = User(
                    id: UUID(),
                    name: email.components(separatedBy: "@").first ?? "",
                    email: email
                )
                
                let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
                
                self.persistSession(user: user, token: token)
                promise(.success(user))
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: work)
        }.eraseToAnyPublisher()
    }
    
    func signUp(email: String, password: String, displayName: String) -> AnyPublisher<User, Error> {
        // Simulation d'une requête API
        return Future<User, Error> { promise in
            let work = DispatchWorkItem {
                // Validation basique
                guard email.contains("@") else {
                    promise(.failure(AuthError.invalidEmail))
                    return
                }
                guard password.count >= 6 else {
                    promise(.failure(AuthError.invalidPassword))
                    return
                }
                guard !displayName.isEmpty else {
                    promise(.failure(AuthError.invalidDisplayName))
                    return
                }
                
                // Simuler une réponse réussie
                let user = User(
                    id: UUID(),
                    name: displayName,
                    email: email
                )
                
                // Simuler un token JWT
                let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
                
                self.persistSession(user: user, token: token)
                promise(.success(user))
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: work)
        }.eraseToAnyPublisher()
    }
    func signOut() -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            self.clearPersistedSession()
            promise(.success(()))
        }.eraseToAnyPublisher()
    }
    
    func resetPassword(email: String) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // Validation basique
                guard email.contains("@") else {
                    promise(.failure(AuthError.invalidEmail))
                    return
                }
                
                // Simuler l'envoi d'un email de réinitialisation
                promise(.success(()))
            }
        }.eraseToAnyPublisher()
    }
}