import Foundation
import Combine

protocol UserRepositoryProtocol {
    // Add your user repository methods here
    // For example:
    func getCurrentUser() -> AnyPublisher<User, Error>
    func updateUserProfile(_ user: User) -> AnyPublisher<User, Error>
} 