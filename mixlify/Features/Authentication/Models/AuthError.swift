import Foundation

/// Représente les différentes erreurs possibles lors de l'authentification
enum AuthError: LocalizedError {
    case invalidEmail
    case invalidPassword
    case invalidDisplayName
    case sessionExpired
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return NSLocalizedString("error.invalid_email", comment: "")
        case .invalidPassword:
            return NSLocalizedString("error.invalid_password", comment: "")
        case .invalidDisplayName:
            return NSLocalizedString("error.invalid_display_name", comment: "")
        case .sessionExpired:
            return NSLocalizedString("error.session_expired", comment: "")
        case .networkError:
            return NSLocalizedString("error.network", comment: "")
        }
    }
} 