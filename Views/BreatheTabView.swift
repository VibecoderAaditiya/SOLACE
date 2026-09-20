import SwiftUI

// MARK: - Breathing Pattern Model
struct BreathingPattern: Identifiable, Equatable {
    let id: String
    let name: String
    let rhythm: String
    let benefit: String
    let colors: [Color]
    let icon: String
}

// MARK: - Breathe Tab View
struct BreatheTabView: View {
    @State private var showingBreathingExercise = false
    @State private var selectedPatternIndex = 0
    @State private var selectedDuration = 3 // minutes

    private let patterns: [BreathingPattern] = [
        BreathingPattern(
            id: "478",
            name: "4-7-8 Relax",
            rhythm: "Inhale 4s · Hold 7s · Exhale 8s",
            benefit: "Deep nervous system calm & sleep",
            colors: [Color(red: 0.20, green: 0.42, blue: 0.58), Color(red: 0.12, green: 0.24, blue: 0.38)],
            icon: "moon.stars.fill"
        ),
        BreathingPattern(
            id: "box",
            name: "Box Breathing",
            rhythm: "Inhale 4s · Hold 4s · Exhale 4s · Hold 4s",
            benefit: "Focus, steady nerves & mental reset",
            colors: [Color(red: 0.22, green: 0.52, blue: 0.42), Color(red: 0.10, green: 0.32, blue: 0.26)],
            icon: "square.fill"
        ),
        BreathingPattern(
            id: "awake",
            name: "Awake & Energize",
            rhythm: "Inhale 2s · Hold 1s · Exhale 2s · Hold 1s",
            benefit: "Oxygenate brain & lift morning energy",
            colors: [Color(red: 0.88, green: 0.50, blue: 0.32), Color(red: 0.72, green: 0.30, blue: 0.20)],
            icon: "sun.max.fill"
        )
    ]

    private let durations = [1, 3, 5, 10]

    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 18) {
                        // 1. Dual Metric Cards Row
                        HStack(spacing: 12) {
                            // Mindful Minutes Card
                            HStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .fill(Color(red: 0.22, green: 0.52, blue: 0.65).opacity(0.15))
                                        .frame(width: 42, height: 42)
                                    Image(systemName: "timer")
                                        .font(.headline)
                                        .foregroundStyle(Color(red: 0.22, green: 0.52, blue: 0.65))
                                }

                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Today's Breath")
                                        .font(.caption2.bold())
                                        .foregroundStyle(.secondary)
                                        .textCase(.uppercase)
                                    HStack(alignment: .firstTextBaseline, spacing: 2) {
                                        Text("8")
                                            .font(.title3.bold())
                                            .foregroundStyle(.primary)
                                        Text("mins")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                            .padding(14)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(Color(uiColor: .secondarySystemGroupedBackground))
                                    .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 4)
                            )

                            // Cycles Completed Card
                            HStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .fill(Color(red: 0.88, green: 0.52, blue: 0.32).opacity(0.15))
                                        .frame(width: 42, height: 42)
                                    Image(systemName: "lungs.fill")
                                        .font(.headline)
                                        .foregroundStyle(Color(red: 0.88, green: 0.52, blue: 0.32))
                                }

                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Cycles")
                                        .font(.caption2.bold())
                                        .foregroundStyle(.secondary)
                                        .textCase(.uppercase)
                                    HStack(alignment: .firstTextBaseline, spacing: 2) {
                                        Text("24")
                                            .font(.title3.bold())
                                            .foregroundStyle(.primary)
                                        Text("breaths")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                            .padding(14)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(Color(uiColor: .secondarySystemGroupedBackground))
                                    .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 4)
                            )
                        }

                        // 2. Pattern Picker Tabs
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Select Pattern")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.secondary)
                                .textCase(.uppercase)
                                .tracking(1)

                            HStack(spacing: 8) {
                                ForEach(Array(patterns.enumerated()), id: \.offset) { index, pattern in
                                    let isSelected = selectedPatternIndex == index

                                    Button {
                                        withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                                            selectedPatternIndex = index
                                        }
                                        SolaceHaptics.pulse()
                                    } label: {
                                        Text(pattern.name)
                                            .font(.caption.bold())
                                            .foregroundStyle(isSelected ? .white : .primary)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 8)
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                Capsule()
                                                    .fill(
                                                        isSelected ?
                                                        LinearGradient(
                                                            colors: pattern.colors,
                                                            startPoint: .topLeading,
                                                            endPoint: .bottomTrailing
                                                        ) :
                                                        LinearGradient(
                                                            colors: [Color.primary.opacity(0.06), Color.primary.opacity(0.06)],
                                                            startPoint: .topLeading,
                                                            endPoint: .bottomTrailing
                                                        )
                                                    )
                                            )
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding(.horizontal, 4)

                        // 3. Hero Interactive Breathing Card
                        let activePattern = patterns[selectedPatternIndex]

                        Button {
                            showingBreathingExercise = true
                            SolaceHaptics.success()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 28, style: .continuous)
                                    .fill(
                                        LinearGradient(
                                            colors: activePattern.colors,
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .shadow(color: activePattern.colors.first?.opacity(0.35) ?? .clear, radius: 14, x: 0, y: 8)

                                // Ambient geometric circles
                                Circle()
                                    .fill(Color.white.opacity(0.07))
                                    .frame(width: 160, height: 160)
                                    .offset(x: 100, y: -50)

                                Circle()
                                    .fill(Color.white.opacity(0.05))
                                    .frame(width: 120, height: 120)
                                    .offset(x: -90, y: 60)

                                VStack(spacing: 12) {
                                    Image(systemName: activePattern.icon)
                                        .font(.system(size: 38, weight: .light))
                                        .foregroundStyle(.white.opacity(0.95))

                                    Text(activePattern.name)
                                        .font(.title2.bold())
                                        .foregroundStyle(.white)

                                    Text(activePattern.rhythm)
                                        .font(.footnote)
                                        .fontWeight(.medium)
                                        .foregroundStyle(.white.opacity(0.85))

                                    Text(activePattern.benefit)
                                        .font(.caption2)
                                        .foregroundStyle(.white.opacity(0.70))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 20)

                                    HStack(spacing: 8) {
                                        Image(systemName: "play.circle.fill")
                                            .font(.headline)
                                        Text("Start \(selectedDuration)m Session")
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                    }
                                    .foregroundStyle(activePattern.colors.first ?? .teal)
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 11)
                                    .background(Capsule().fill(.white))
                                    .padding(.top, 6)
                                }
                                .padding(24)
                            }
                        }
                        .buttonStyle(.interactiveCard)
                        .frame(height: 250)

                        // 4. Session Duration Picker
                        HStack(spacing: 8) {
                            Text("Duration:")
                                .font(.caption.bold())
                                .foregroundStyle(.secondary)
                                .padding(.leading, 4)

                            Spacer()

                            ForEach(durations, id: \.self) { duration in
                                let isSelected = selectedDuration == duration

                                Button {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        selectedDuration = duration
                                    }
                                    SolaceHaptics.pulse()
                                } label: {
                                    Text("\(duration) min")
                                        .font(.caption.bold())
                                        .foregroundStyle(isSelected ? .white : .secondary)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(
                                            Capsule()
                                                .fill(isSelected ? activePattern.colors.first ?? .teal : Color.primary.opacity(0.06))
                                        )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 6)

                        // 5. Rich Library of Mindful Practices
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Mindfulness Library")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.secondary)
                                .textCase(.uppercase)
                                .tracking(1)
                                .padding(.horizontal, 4)

                            ExerciseCard(
                                title: "5-4-3-2-1 Grounding",
                                subtitle: "Anchor your focus with senses",
                                icon: "eye.fill",
                                color: Color(red: 0.28, green: 0.58, blue: 0.85),
                                duration: "5 min"
                            )

                            ExerciseCard(
                                title: "Full Body Tension Scan",
                                subtitle: "Progressive muscle release",
                                icon: "figure.mind.and.body",
                                color: Color(red: 0.65, green: 0.45, blue: 0.85),
                                duration: "8 min"
                            )

                            ExerciseCard(
                                title: "Resonance Coherence",
                                subtitle: "Balance heart & vagus nerve",
                                icon: "waveform.path.ecg",
                                color: Color(red: 0.88, green: 0.45, blue: 0.40),
                                duration: "6 min"
                            )

                            ExerciseCard(
                                title: "Walking Breath Meditation",
                                subtitle: "Mindful steps with breathing",
                                icon: "figure.walk",
                                color: Color(red: 0.32, green: 0.68, blue: 0.48),
                                duration: "10 min"
                            )
                        }
                    }
                    .padding(16)
                    .padding(.bottom, 120) // room for tab bar
                }
            }
            .navigationTitle("Breathe")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showingBreathingExercise) {
                BreathingExerciseView()
            }
        }
    }
}

// MARK: - Colorful Exercise Card
struct ExerciseCard: View {
    let title: String
    let subtitle: String
    let icon: String
    var color: Color = Color(red: 0.15, green: 0.30, blue: 0.25)
    var duration: String = ""

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.14))
                    .frame(width: 48, height: 48)

                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(color)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.subheadline.bold())
                    .foregroundStyle(.primary)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                if !duration.isEmpty {
                    Text(duration)
                        .font(.caption2.bold())
                        .foregroundStyle(color)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Capsule().fill(color.opacity(0.12)))
                }
                Image(systemName: "chevron.right")
                    .font(.caption2.bold())
                    .foregroundStyle(.tertiary)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(uiColor: .secondarySystemGroupedBackground))
                .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 4)
        )
    }
}

#Preview {
    BreatheTabView()
}
