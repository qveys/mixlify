import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var displayName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isFormValid = false
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 16) {
                AuthTextField(
                    title: "Nom d'affichage",
                    placeholder: "Entrez votre nom",
                    text: $displayName,
                    validation: Validators.displayName
                )
                
                AuthTextField(
                    title: "Email",
                    placeholder: "Entrez votre email",
                    text: $email,
                    validation: Validators.email
                )
                
                AuthTextField(
                    title: "Mot de passe",
                    placeholder: "Entrez votre mot de passe",
                    text: $password,
                    isSecure: true,
                    validation: Validators.password
                )
                
                AuthTextField(
                    title: "Confirmer le mot de passe",
                    placeholder: "Confirmez votre mot de passe",
                    text: $confirmPassword,
                    isSecure: true,
                    validation: { password in
                        let result = password == self.password
                        return ValidationResult(
                            isValid: result,
                            errorMessage: result ? "" : "Les mots de passe ne correspondent pas"
                        )
                    }
                )
            }
            
            if case .error(let message) = viewModel.state {
                Text(message)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            Button(action: {
                viewModel.dispatch(.signUp(
                    displayName: displayName,
                    email: email,
                    password: password
                ))
            }) {
                if viewModel.state == .authenticating {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("Créer un compte")
                }
            }
            .primaryButton()
            .disabled(!isFormValid || viewModel.state == .authenticating)
        }
        .padding()
        .navigationTitle("Inscription")
        .navigationBarItems(trailing: Button("Annuler") {
            dismiss()
        })
        .onChange(of: displayName) { validateForm() }
        .onChange(of: email) { validateForm() }
        .onChange(of: password) { validateForm() }
        .onChange(of: confirmPassword) { validateForm() }
    }
    
    private func validateForm() {
        let displayNameValidation = Validators.displayName(displayName)
        let emailValidation = Validators.email(email)
        let passwordValidation = Validators.password(password)
        let confirmPasswordValidation = password == confirmPassword
        
        isFormValid = displayNameValidation.isValid &&
                     emailValidation.isValid &&
                     passwordValidation.isValid &&
                     confirmPasswordValidation
    }
} 