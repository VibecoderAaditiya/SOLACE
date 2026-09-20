import SwiftUI

struct WelcomeView: View {
    @Binding var hasLaunched: Bool
    
    var body: some View {
        ZStack {
            // Calming deep emerald to dark slate gradient
            LinearGradient(
                colors: [Color(red: 0.08, green: 0.18, blue: 0.15), Color(red: 0.06, green: 0.09, blue: 0.12)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 32) {
                Spacer()
                
                VStack(spacing: 12) {
                    Text("SOLACE")
                        .font(.system(size: 48, weight: .thin, design: .serif))
                        .tracking(8)
                        .foregroundStyle(.white)
                    
                    Text("A silent place")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .tracking(3)
                        .foregroundStyle(.white.opacity(0.7))
                }
                
                Spacer()
                
                Text("Your luxury mental wellness journal.")
                    .font(.callout)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white.opacity(0.6))
                    .padding(.horizontal, 40)
                
                Button(action: {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                        hasLaunched = true
                    }
                }) {
                    Text("Begin")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundStyle(Color(red: 0.08, green: 0.18, blue: 0.15))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Capsule().fill(Color.white))
                        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    WelcomeView(hasLaunched: .constant(false))
}
