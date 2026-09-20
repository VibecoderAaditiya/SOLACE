import SwiftUI

struct MoodTrackerView: View {
    @AppStorage("showMoodPrompt") private var showMoodPrompt: Bool = true
    @State private var selectedMood: Mood? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Today's Mood")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                    .textCase(.uppercase)
                    .tracking(1)

                Spacer()

                if let mood = selectedMood {
                    Text(mood.title)
                        .font(.caption.bold())
                        .foregroundStyle(moodColor(for: mood).0)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(moodColor(for: mood).0.opacity(0.15))
                        )
                        .transition(.scale.combined(with: .opacity))
                }
            }

            HStack(spacing: 0) {
                ForEach(Mood.allCases, id: \.self) { mood in
                    let isSelected = selectedMood == mood
                    let colors = moodColor(for: mood)

                    Button {
                        SolaceHaptics.pulse()
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.65)) {
                            selectedMood = mood
                        }
                    } label: {
                        VStack(spacing: 8) {
                            ZStack {
                                if isSelected {
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                colors: [colors.0, colors.1],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .frame(width: 48, height: 48)
                                        .shadow(color: colors.0.opacity(0.40), radius: 8, x: 0, y: 4)
                                } else {
                                    Circle()
                                        .fill(colors.0.opacity(0.12))
                                        .frame(width: 46, height: 46)
                                }

                                Image(systemName: mood.icon)
                                    .font(.title3)
                                    .foregroundStyle(isSelected ? .white : colors.0)
                            }
                            .scaleEffect(isSelected ? 1.15 : 1.0)

                            Text(mood.title)
                                .font(.caption2)
                                .fontWeight(isSelected ? .bold : .medium)
                                .foregroundStyle(isSelected ? colors.0 : Color.secondary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.plain)
                }
            }

            if showMoodPrompt, let mood = selectedMood {
                HStack(spacing: 10) {
                    Image(systemName: "sparkle")
                        .font(.caption)
                        .foregroundStyle(moodColor(for: mood).0)

                    Text(moodPrompt(for: mood))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .italic()
                }
                .padding(.top, 4)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(uiColor: .secondarySystemGroupedBackground))
                .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
        )
    }

    private func moodColor(for mood: Mood) -> (Color, Color) {
        switch mood {
        case .happy:
            return (Color(red: 0.95, green: 0.68, blue: 0.22), Color(red: 0.90, green: 0.48, blue: 0.15))
        case .sad:
            return (Color(red: 0.38, green: 0.58, blue: 0.82), Color(red: 0.22, green: 0.40, blue: 0.68))
        case .angry:
            return (Color(red: 0.92, green: 0.42, blue: 0.36), Color(red: 0.78, green: 0.26, blue: 0.22))
        case .neutral:
            return (Color(red: 0.42, green: 0.68, blue: 0.56), Color(red: 0.22, green: 0.48, blue: 0.38))
        case .excited:
            return (Color(red: 0.95, green: 0.48, blue: 0.56), Color(red: 0.86, green: 0.28, blue: 0.46))
        case .anxious:
            return (Color(red: 0.65, green: 0.52, blue: 0.86), Color(red: 0.48, green: 0.32, blue: 0.74))
        }
    }

    private func moodPrompt(for mood: Mood) -> String {
        switch mood {
        case .happy: return "What brought light to your day?"
        case .sad: return "What would you like to be gentle with right now?"
        case .angry: return "Take a slow breath. What can you release today?"
        case .neutral: return "What simple thing brought you comfort?"
        case .excited: return "What is energizing your spirit right now?"
        case .anxious: return "Breathe in ease, exhale tension. You are safe here."
        }
    }
}

#Preview {
    MoodTrackerView()
}
