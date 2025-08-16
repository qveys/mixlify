import SwiftUI

struct AuthenticationView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @State private var showingSignUp = false
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.state == .authenticated {
                    VStack(spacing: 20) {
                        // En-tête avec le nom d'utilisateur
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .font(.title)
                            Text("Connecté en tant que \(viewModel.currentUser?.displayName ?? "Utilisateur")")
                                .font(.headline)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(10)
                        
                        ConversationsView()
                        
                        // Bouton de déconnexion en bas
                        Button(action: {
                            viewModel.dispatch(.signOut)
                        }) {
                            HStack {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                Text("Se déconnecter")
                            }
                            .font(.headline)
                        }
                        .primaryButton()
                    }
                    .padding()
                    .navigationTitle("Mon Profil")
                } else {
                    VStack(spacing: 20) {
                        Text("Bienvenue sur Mixlify")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Connectez-vous pour accéder à vos messages")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.bottom)
                        
                        SignInView(viewModel: viewModel)
                        
                        Button("Créer un compte") {
                            showingSignUp = true
                        }
                        .font(.headline)
                        .foregroundColor(.accentColor)
                        .padding(.top)
                    }
                    .padding()
                    .navigationTitle("Connexion")
                }
            }
        }
        .sheet(isPresented: $showingSignUp) {
            NavigationView {
                SignUpView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    AuthenticationView()
} 