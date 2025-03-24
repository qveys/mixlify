import Foundation
import Combine

protocol PlayerServiceProtocol: ServiceProtocol {
    // Add your player-related methods here
    // For example:
    func play(track: Track)
    func pause()
    func stop()
    var currentTrack: AnyPublisher<Track?, Never> { get }
    var isPlaying: AnyPublisher<Bool, Never> { get }
} 