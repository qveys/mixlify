import Foundation
import Combine

protocol AuthServiceProtocol: ServiceProtocol {
    func signIn(email: String, password: String) -> AnyPublisher<User, Error>
    func signUp(email: String, password: String, displayName: String) -> AnyPublisher<User, Error>
    func signOut() -> AnyPublisher<Void, Error>
    func resetPassword(email: String) -> AnyPublisher<Void, Error>
    var currentUser: User? { get }
} 