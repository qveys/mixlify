import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: AuthenticationViewModel
    @State private var email = ""
    @State private var isFormValid = false
    @State private var showingSuccessAlert = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Reset Password")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Enter your email address and we'll send you instructions to reset your password.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                AuthTextField(
                    title: "Email",
                    placeholder: "Enter your email",
                    text: $email,
                    validation: Validators.email
                )
                
                Button("Send Reset Link") {
                    viewModel.dispatch(.resetPassword(email: email))
                    showingSuccessAlert = true
                }
                .primaryButton()
                .disabled(!isFormValid || viewModel.state == .authenticating)
                
                if case .authenticating = viewModel.state {
                    ProgressView()
                        .padding(.top)
                }
                
                if case .error(let message) = viewModel.state {
                    Text(message)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Reset Link Sent", isPresented: $showingSuccessAlert) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text("Check your email for instructions to reset your password.")
            }
            .onChange(of: email) { validateForm() }
        }
    }
    
    private func validateForm() {
        let emailValidation = Validators.email(email)
        isFormValid = emailValidation.isValid
    }
} 