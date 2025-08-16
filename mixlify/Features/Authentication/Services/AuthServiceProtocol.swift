import Foundation
import Combine

protocol AuthServiceProtocol: ServiceProtocol {
    var currentUser: User? { get }
    var isAuthenticated: Bool { get }
    
    func signIn(email: String, password: String) -> AnyPublisher<User, Error>
    func signUp(email: String, password: String, displayName: String) -> AnyPublisher<User, Error>
    func signOut() -> AnyPublisher<Void, Error>
    func resetPassword(email: String) -> AnyPublisher<Void, Error>
} 