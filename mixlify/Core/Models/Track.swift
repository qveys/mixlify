import Foundation

struct Track: Identifiable, Codable, Equatable {
    let id: String
    let title: String
    let artist: String
    let albumName: String?
    let duration: TimeInterval
    let artworkURL: URL?
    let previewURL: URL?
    
    var displayTitle: String {
        "\(title) - \(artist)"
    }
} 