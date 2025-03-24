import Foundation
import Combine

final class PlayerService: PlayerServiceProtocol {
    var cancellables: Set<AnyCancellable> = []
    
    private let currentTrackSubject = CurrentValueSubject<Track?, Never>(nil)
    private let isPlayingSubject = CurrentValueSubject<Bool, Never>(false)
    
    var currentTrack: AnyPublisher<Track?, Never> {
        currentTrackSubject.eraseToAnyPublisher()
    }
    
    var isPlaying: AnyPublisher<Bool, Never> {
        isPlayingSubject.eraseToAnyPublisher()
    }
    
    func play(track: Track) {
        currentTrackSubject.send(track)
        isPlayingSubject.send(true)
        // TODO: Implement actual playback logic
    }
    
    func pause() {
        isPlayingSubject.send(false)
        // TODO: Implement actual pause logic
    }
    
    func stop() {
        currentTrackSubject.send(nil)
        isPlayingSubject.send(false)
        // TODO: Implement actual stop logic
    }
} 