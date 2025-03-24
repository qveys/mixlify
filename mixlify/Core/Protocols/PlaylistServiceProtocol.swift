import Foundation
import Combine

protocol PlaylistServiceProtocol: ServiceProtocol {
    // Add your playlist-related methods here
    // For example:
    func fetchPlaylists() -> AnyPublisher<[Playlist], Error>
    func createPlaylist(name: String) -> AnyPublisher<Playlist, Error>
} 