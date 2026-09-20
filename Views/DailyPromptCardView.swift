import SwiftUI

struct DailyPromptCardView: View {
    var onReflectTapped: (() -> Void)? = nil
    @State private var currentPromptIndex: Int = 0

    private let prompts = Prompt.seedPrompts

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: "pencil.line")
                        .font(.caption)
                        .foregroundStyle(Color(red: 0.85, green: 0.45, blue: 0.55))

                    Text("Prompt of the Day")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)
                        .tracking(1)
                }

                Spacer()

                Button {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                        currentPromptIndex = (currentPromptIndex + 1) % prompts.count
                    }
                    SolaceHaptics.pulse()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.caption2)
                        Text("Next")
                            .font(.caption2.bold())
                    }
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Capsule().fill(Color.primary.opacity(0.06)))
                }
            }

            Text(prompts[currentPromptIndex])
                .font(.system(.title3, design: .serif))
                .fontWeight(.medium)
                .foregroundStyle(.primary)
                .lineSpacing(3)
                .id(currentPromptIndex)
                .transition(.asymmetric(insertion: .opacity.combined(with: .move(edge: .trailing)), removal: .opacity))

            HStack {
                Text("Self-Reflection")
                    .font(.caption2.bold())
                    .foregroundStyle(Color(red: 0.85, green: 0.45, blue: 0.55))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color(red: 0.85, green: 0.45, blue: 0.55).opacity(0.12))
                    )

                Spacer()

                Button {
                    onReflectTapped?()
                    SolaceHaptics.pulse()
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "square.and.pencil")
                            .font(.caption)
                        Text("Write Response")
                            .font(.footnote.bold())
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [Color(red: 0.85, green: 0.45, blue: 0.55), Color(red: 0.75, green: 0.35, blue: 0.50)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(uiColor: .secondarySystemGroupedBackground))
                .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
        )
    }
}

#Preview {
    DailyPromptCardView()
        .padding()
}
