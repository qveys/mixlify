import Foundation
import Combine

protocol TrackRepositoryProtocol {
    // Add your track repository methods here
    // For example:
    func fetchTracks() -> AnyPublisher<[Track], Error>
    func searchTracks(query: String) -> AnyPublisher<[Track], Error>
    func saveTrack(_ track: Track) -> AnyPublisher<Track, Error>
} 