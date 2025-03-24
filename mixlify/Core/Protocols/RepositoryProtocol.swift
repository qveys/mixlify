import Foundation
import Combine

protocol RepositoryProtocol {
    associatedtype Entity
    associatedtype ID
    
    func fetch(id: ID) -> AnyPublisher<Entity, Error>
    func fetchAll() -> AnyPublisher<[Entity], Error>
    func create(_ entity: Entity) -> AnyPublisher<Entity, Error>
    func update(_ entity: Entity) -> AnyPublisher<Entity, Error>
    func delete(id: ID) -> AnyPublisher<Void, Error>
} 