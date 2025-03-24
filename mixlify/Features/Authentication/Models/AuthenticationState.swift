import Foundation

// Using the User model from Core/Models/User.swift
enum AuthenticationState: Equatable {
    case idle
    case authenticating
    case authenticated(User)
    case error(String)
}
// Removed duplicate User struct definition as we're using the one from Core/Models/User.swift 