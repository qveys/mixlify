import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: AuthenticationViewModel
    @State private var email = ""
    
    var body: some View {
        NavigationView {
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
                    text: $email
                )
                
                Button("Send Reset Link") {
                    viewModel.dispatch(AuthenticationViewModel.Action.resetPassword(email: email))
                    dismiss()
                }
                .primaryButton()
                .disabled(email.isEmpty)
            }
            .padding()
            .navigationBarItems(trailing: Button("Cancel") {
                dismiss()
            })
        }
    }
} 