import SwiftUI

struct JournalQuickEntryView: View {
    var onSave: ((String, Mood?, [String]) -> Void)? = nil

    @State private var quickText = ""
    @State private var selectedMood: Mood? = .happy
    @State private var selectedTags: Set<String> = ["gratitude"]
    @State private var isSaved = false

    private struct PromptChip: Identifiable {
        let id: String
        let title: String
        let promptText: String
        let color: Color
    }

    private let promptChips: [PromptChip] = [
        PromptChip(
            id: "gratitude",
            title: "✨ Gratitude",
            promptText: "I am grateful today for ",
            color: Color(red: 0.95, green: 0.65, blue: 0.20)
        ),
        PromptChip(
            id: "release",
            title: "🌿 Letting Go",
            promptText: "Right now I am choosing to release ",
            color: Color(red: 0.25, green: 0.55, blue: 0.40)
        ),
        PromptChip(
            id: "win",
            title: "🎯 Small Win",
            promptText: "One small win I am celebrating today is ",
            color: Color(red: 0.85, green: 0.45, blue: 0.55)
        ),
        PromptChip(
            id: "clarity",
            title: "💭 Clarity",
            promptText: "The intention that will guide my next steps is ",
            color: Color(red: 0.35, green: 0.55, blue: 0.80)
        ),
        PromptChip(
            id: "evening",
            title: "🌙 Evening Unwind",
            promptText: "Looking back on my day, the calmest moment was ",
            color: Color(red: 0.58, green: 0.45, blue: 0.78)
        )
    ]

    private let availableTags = ["gratitude", "peace", "nature", "focus", "sleep", "healing"]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Header
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: "square.and.pencil")
                        .font(.caption)
                        .foregroundStyle(Color(red: 0.22, green: 0.48, blue: 0.38))

                    Text("Express & Reflect")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)
                        .tracking(1)
                }

                Spacer()

                if isSaved {
                    Label("Saved to Journal", systemImage: "checkmark.circle.fill")
                        .font(.caption.bold())
                        .foregroundStyle(Color(red: 0.25, green: 0.55, blue: 0.38))
                        .transition(.scale.combined(with: .opacity))
                }
            }

            // 1. Prompt Inspiration Chips
            VStack(alignment: .leading, spacing: 6) {
                Text("Tap to Start:")
                    .font(.caption2.bold())
                    .foregroundStyle(.secondary)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(promptChips) { chip in
                            Button {
                                quickText = chip.promptText
                                SolaceHaptics.pulse()
                            } label: {
                                Text(chip.title)
                                    .font(.caption.bold())
                                    .foregroundStyle(chip.color)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(
                                        Capsule()
                                            .fill(chip.color.opacity(0.12))
                                    )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }

            // 2. Text Input Area
            TextField("What is on your heart and mind right now?", text: $quickText, axis: .vertical)
                .lineLimit(3...6)
                .padding(14)
                .background(Color(uiColor: .tertiarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

            // 3. Mood Pill Selector
            HStack(spacing: 8) {
                Text("Mood:")
                    .font(.caption2.bold())
                    .foregroundStyle(.secondary)

                ForEach(Mood.allCases, id: \.self) { mood in
                    let isSelected = selectedMood == mood
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedMood = mood
                        }
                        SolaceHaptics.pulse()
                    } label: {
                        Image(systemName: mood.icon)
                            .font(.caption)
                            .foregroundStyle(isSelected ? .white : .secondary)
                            .padding(7)
                            .background(
                                Circle()
                                    .fill(isSelected ? Color(red: 0.25, green: 0.50, blue: 0.40) : Color.primary.opacity(0.06))
                            )
                    }
                    .buttonStyle(.plain)
                }
            }

            // 4. Tag Pills
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    ForEach(availableTags, id: \.self) { tag in
                        let isSelected = selectedTags.contains(tag)

                        Button {
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                                if isSelected {
                                    selectedTags.remove(tag)
                                } else {
                                    selectedTags.insert(tag)
                                }
                            }
                            SolaceHaptics.pulse()
                        } label: {
                            Text("#\(tag)")
                                .font(.caption2.bold())
                                .foregroundStyle(isSelected ? Color.white : Color.secondary)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(
                                    Capsule()
                                        .fill(isSelected ? Color(red: 0.22, green: 0.48, blue: 0.38) : Color.primary.opacity(0.06))
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }

            // 5. Save Button Row
            HStack {
                Spacer()
                Button(action: {
                    guard !quickText.isEmpty else { return }
                    onSave?(quickText, selectedMood, Array(selectedTags))
                    SolaceHaptics.success()

                    withAnimation(.spring()) {
                        isSaved = true
                        quickText = ""
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isSaved = false
                        }
                    }
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "checkmark")
                            .font(.caption.bold())
                        Text("Save Entry")
                            .font(.footnote.bold())
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 22)
                    .padding(.vertical, 10)
                    .background(
                        Capsule()
                            .fill(
                                quickText.isEmpty ?
                                LinearGradient(colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.3)], startPoint: .top, endPoint: .bottom) :
                                LinearGradient(colors: [Color(red: 0.22, green: 0.52, blue: 0.42), Color(red: 0.12, green: 0.32, blue: 0.26)], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    )
                }
                .disabled(quickText.isEmpty)
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
    JournalQuickEntryView()
        .padding()
}
