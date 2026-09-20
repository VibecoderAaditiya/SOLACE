import SwiftUI

struct InspirationalQuoteView: View {
    struct Quote {
        let text: String
        let author: String
    }
    
    private static let curatedQuotes: [Quote] = [
        Quote(text: "Silence is a source of great strength.", author: "Lao Tzu"),
        Quote(text: "Within you, there is a stillness and a sanctuary to which you can retreat at any time.", author: "Hermann Hesse"),
        Quote(text: "Peace comes from within. Do not seek it without.", author: "Buddha"),
        Quote(text: "Almost everything will work again if you unplug it for a few minutes, including you.", author: "Anne Lamott"),
        Quote(text: "Calmness is the cradle of power.", author: "Josiah Gilbert Holland"),
        Quote(text: "In the depth of winter, I finally learned that within me there lay an invincible summer.", author: "Albert Camus")
    ]
    
    @State private var currentQuote: Quote = curatedQuotes.randomElement()!
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Inspiration")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                    .textCase(.uppercase)
                    .tracking(1)
                
                Spacer()
                
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        currentQuote = Self.curatedQuotes.filter { $0.text != currentQuote.text }.randomElement() ?? Self.curatedQuotes[0]
                    }
                } label: {
                    Image(systemName: "shuffle")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Text("\"\(currentQuote.text)\"")
                .font(.system(.title3, design: .serif))
                .fontWeight(.regular)
                .foregroundStyle(.primary)
                .lineSpacing(4)
                .transition(.opacity.combined(with: .slide))
                .id(currentQuote.text)
            
            Text("— \(currentQuote.author)")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(uiColor: .secondarySystemGroupedBackground))
                .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 4)
        )
    }
}

#Preview {
    InspirationalQuoteView()
}
