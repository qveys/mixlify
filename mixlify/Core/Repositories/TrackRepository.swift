import Foundation
import Combine

final class TrackRepository: TrackRepositoryProtocol {
    func fetchTracks() -> AnyPublisher<[Track], Error> {
        // TODO: Implement actual tracks fetching logic
        return Just([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func searchTracks(query: String) -> AnyPublisher<[Track], Error> {
        // TODO: Implement actual track search logic
        return Just([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func saveTrack(_ track: Track) -> AnyPublisher<Track, Error> {
        // TODO: Implement actual track saving logic
        return Just(track)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
} 