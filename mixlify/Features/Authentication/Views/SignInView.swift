import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: AuthenticationViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showingForgotPassword = false
    @State private var isFormValid = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome Back")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(spacing: 16) {
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
            }
            
            if case .error(let message) = viewModel.state {
                Text(message)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            Button("Mot de passe oublié ?", action: {
                showingForgotPassword = true
            })
            .font(.footnote)
            .foregroundColor(.accentColor)
            
            Button(action: {
                viewModel.dispatch(.signIn(email: email, password: password))
            }) {
                if viewModel.state == .authenticating {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("Se connecter")
                }
            }
            .primaryButton()
            .disabled(!isFormValid || viewModel.state == .authenticating)
        }
        .padding()
        .sheet(isPresented: $showingForgotPassword) {
            NavigationView {
                ForgotPasswordView(viewModel: viewModel)
            }
        }
        .onChange(of: email) { validateForm() }
        .onChange(of: password) { validateForm() }
    }
    
    private func validateForm() {
        let emailValidation = Validators.email(email)
        let passwordValidation = Validators.password(password)
        isFormValid = emailValidation.isValid && passwordValidation.isValid
    }
} 