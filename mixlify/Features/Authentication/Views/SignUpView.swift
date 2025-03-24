import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var displayName = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(spacing: 16) {
                AuthTextField(
                    title: "Name",
                    placeholder: "Enter your name",
                    text: $displayName
                )
                
                AuthTextField(
                    title: "Email",
                    placeholder: "Enter your email",
                    text: $email
                )
                
                AuthTextField(
                    title: "Password",
                    placeholder: "Choose a password",
                    text: $password,
                    isSecure: true
                )
            }
            
            Button("Sign Up") {
                viewModel.dispatch(AuthenticationViewModel.Action.signUp(
                    email: email,
                    password: password,
                    displayName: displayName
                ))
            }
            .primaryButton()
            .disabled(email.isEmpty || password.isEmpty || displayName.isEmpty)
            
            if case .error(let message) = viewModel.state {
                Text(message)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
        }
        .padding()
    }
} 