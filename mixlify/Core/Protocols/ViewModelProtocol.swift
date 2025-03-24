import Foundation
import Combine

protocol ViewModelProtocol: ObservableObject {
    associatedtype State
    
    var state: State { get }
    func dispatch(_ action: Any)
}

@propertyWrapper
struct Injected<T> {
    private let keyPath: WritableKeyPath<InjectionContainer, T>
    
    var wrappedValue: T {
        get { InjectionContainer.shared[keyPath: keyPath] }
        set { InjectionContainer.shared[keyPath: keyPath] = newValue }
    }
    
    init(_ keyPath: WritableKeyPath<InjectionContainer, T>) {
        self.keyPath = keyPath
    }
} 