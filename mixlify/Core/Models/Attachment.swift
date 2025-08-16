import Foundation

struct Attachment: Identifiable, Codable, Equatable {
    let id: UUID
    var url: URL
    var type: AttachmentType
    var previewImage: URL?
    
    static func == (lhs: Attachment, rhs: Attachment) -> Bool {
        lhs.id == rhs.id &&
        lhs.url == rhs.url &&
        lhs.type == rhs.type &&
        lhs.previewImage == rhs.previewImage
    }
}

enum AttachmentType: String, Codable, Equatable {
    case image
    case video
    case audio
    case document
    case location
} 