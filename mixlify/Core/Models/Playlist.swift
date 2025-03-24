import Foundation

struct Playlist: Identifiable, Codable, Equatable {
    let id: String
    var name: String
    var description: String?
    var tracks: [Track]
    var createdAt: Date
    var updatedAt: Date
    
    var trackCount: Int {
        tracks.count
    }
    
    var totalDuration: TimeInterval {
        tracks.reduce(0) { $0 + $1.duration }
    }
} 