import SwiftUI

struct AuthenticationView: View {
    @State private var showingSignUp = false
    
    var body: some View {
        NavigationView {
            VStack {
                SignInView()
                
                Divider()
                    .padding(.vertical)
                
                Button("Don't have an account? Sign Up") {
                    showingSignUp = true
                }
                .font(.footnote)
                .foregroundColor(.accentColor)
            }
            .sheet(isPresented: $showingSignUp) {
                SignUpView()
            }
        }
    }
} 