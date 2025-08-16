import SwiftUI

struct AuthTextField: View {
    let title: String
    let placeholder: String
    let text: Binding<String>
    var isSecure: Bool = false
    var validation: ((String) -> ValidationResult)?
    @State private var isValid: Bool = true
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if isSecure {
                SecureField(placeholder, text: text)
                    .textFieldStyle(.roundedBorder)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(isValid ? Color.clear : Color.red, lineWidth: 1)
                    )
                    .onChange(of: text.wrappedValue) { _, newValue in
                        validateInput(newValue)
                    }
            } else {
                TextField(placeholder, text: text)
                    .textFieldStyle(.roundedBorder)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(isValid ? Color.clear : Color.red, lineWidth: 1)
                    )
                    .onChange(of: text.wrappedValue) { _, newValue in
                        validateInput(newValue)
                    }
            }
            
            if !isValid {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .padding(.vertical, 4)
    }
    
    private func validateInput(_ value: String) {
        if let validation = validation {
            let result = validation(value)
            isValid = result.isValid
            errorMessage = result.message ?? ""
        } else {
            isValid = true
            errorMessage = ""
        }
    }
}

struct ValidationResult {
    let isValid: Bool
    let message: String?
    
    static func valid() -> ValidationResult {
        ValidationResult(isValid: true, message: nil)
    }
    
    static func invalid(_ message: String) -> ValidationResult {
        ValidationResult(isValid: false, message: message)
    }
}

// Validateurs prédéfinis
struct Validators {
    static func email(_ value: String) -> ValidationResult {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if value.isEmpty {
            return .invalid("L'email est requis")
        }
        
        if !emailPredicate.evaluate(with: value) {
            return .invalid("Format d'email invalide")
        }
        
        return .valid()
    }
    
    static func password(_ value: String) -> ValidationResult {
        if value.isEmpty {
            return .invalid("Le mot de passe est requis")
        }
        
        if value.count < 6 {
            return .invalid("Le mot de passe doit contenir au moins 6 caractères")
        }
        
        return .valid()
    }
    
    static func displayName(_ value: String) -> ValidationResult {
        if value.isEmpty {
            return .invalid("Le nom est requis")
        }
        
        if value.count < 2 {
            return .invalid("Le nom doit contenir au moins 2 caractères")
        }
        
        return .valid()
    }
} 