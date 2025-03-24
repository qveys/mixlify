import Foundation

final class InjectionContainer {
    static var shared = InjectionContainer()
    
    private init() {}
    
    // Services
    var authService: AuthServiceProtocol = AuthService()
    var playlistService: PlaylistServiceProtocol = PlaylistService()
    var playerService: PlayerServiceProtocol = PlayerService()
    
    // Repositories
    var userRepository: UserRepositoryProtocol = UserRepository()
    var trackRepository: TrackRepositoryProtocol = TrackRepository()
} 