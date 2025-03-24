import Foundation
import Combine

protocol ServiceProtocol {
    var cancellables: Set<AnyCancellable> { get set }
}

extension ServiceProtocol {
    mutating func store<T: Publisher>(
        _ publisher: T,
        completion: @escaping (T.Output) -> Void
    ) {
        publisher
            .sink(
                receiveCompletion: { _ in },
                receiveValue: completion
            )
            .store(in: &cancellables)
    }
} 