import SwiftUI

struct SignInView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var showingForgotPassword = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome Back")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(spacing: 16) {
                AuthTextField(
                    title: "Email",
                    placeholder: "Enter your email",
                    text: $email
                )
                
                AuthTextField(
                    title: "Password",
                    placeholder: "Enter your password",
                    text: $password,
                    isSecure: true
                )
            }
            
            Button("Forgot Password?") {
                showingForgotPassword = true
            }
            .font(.footnote)
            
            Button("Sign In") {
                viewModel.dispatch(AuthenticationViewModel.Action.signIn(
                    email: email,
                    password: password
                ))
            }
            .primaryButton()
            .disabled(email.isEmpty || password.isEmpty)
            
            if case .error(let message) = viewModel.state {
                Text(message)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
        }
        .padding()
        .sheet(isPresented: $showingForgotPassword) {
            ForgotPasswordView(viewModel: viewModel)
        }
    }
}