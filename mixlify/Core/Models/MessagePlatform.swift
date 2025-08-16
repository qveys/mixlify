import Foundation

enum MessagePlatform: String, Codable, Equatable {
    case whatsapp
    case messenger
    case instagram
    case iMessage
    case sms
    case twitter
    case telegram
    
    var displayName: String {
        switch self {
        case .whatsapp: return "WhatsApp"
        case .messenger: return "Messenger"
        case .instagram: return "Instagram"
        case .iMessage: return "iMessage"
        case .sms: return "SMS"
        case .twitter: return "Twitter"
        case .telegram: return "Telegram"
        }
    }
} 