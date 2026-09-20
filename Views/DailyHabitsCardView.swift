import SwiftUI

struct DailyHabit: Identifiable {
    let id: String
    let emoji: String
    let title: String
    let category: String
    let color: Color
}

struct DailyHabitsCardView: View {
    @State private var completedHabits: Set<String> = ["sunlight"]

    private let habits: [DailyHabit] = [
        DailyHabit(
            id: "sunlight",
            emoji: "☀️",
            title: "5m Morning Light",
            category: "Circadian",
            color: Color(red: 0.95, green: 0.65, blue: 0.20)
        ),
        DailyHabit(
            id: "breathe",
            emoji: "🌬️",
            title: "3 Deep Conscious Breaths",
            category: "Autonomic",
            color: Color(red: 0.28, green: 0.62, blue: 0.72)
        ),
        DailyHabit(
            id: "gratitude",
            emoji: "✍️",
            title: "Notice One Small Win",
            category: "Mindset",
            color: Color(red: 0.85, green: 0.45, blue: 0.55)
        ),
        DailyHabit(
            id: "hydrate",
            emoji: "💧",
            title: "Sip Water with Presence",
            category: "Wellness",
            color: Color(red: 0.35, green: 0.58, blue: 0.90)
        )
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header with Progress Counter
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Daily Micro-Rituals")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)
                        .tracking(1)

                    Text("\(completedHabits.count) of \(habits.count) Completed")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(completedHabits.count == habits.count ? Color(red: 0.25, green: 0.55, blue: 0.38) : .secondary)
                }

                Spacer()

                // Small Circular/Capsule Progress Ring
                ZStack {
                    Circle()
                        .stroke(Color.primary.opacity(0.08), lineWidth: 4)
                        .frame(width: 36, height: 36)

                    Circle()
                        .trim(from: 0, to: CGFloat(completedHabits.count) / CGFloat(habits.count))
                        .stroke(
                            LinearGradient(
                                colors: [Color(red: 0.28, green: 0.62, blue: 0.72), Color(red: 0.95, green: 0.65, blue: 0.20)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            style: StrokeStyle(lineWidth: 4, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                        .frame(width: 36, height: 36)
                        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: completedHabits.count)

                    Text("\(Int((Double(completedHabits.count) / Double(habits.count)) * 100))%")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundStyle(.primary)
                }
            }

            // Habits List
            VStack(spacing: 10) {
                ForEach(habits) { habit in
                    let isDone = completedHabits.contains(habit.id)

                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                            if isDone {
                                completedHabits.remove(habit.id)
                            } else {
                                completedHabits.insert(habit.id)
                                SolaceHaptics.success()
                            }
                        }
                    } label: {
                        HStack(spacing: 12) {
                            // Emoji badge
                            Text(habit.emoji)
                                .font(.title3)
                                .frame(width: 36, height: 36)
                                .background(
                                    Circle()
                                        .fill(habit.color.opacity(0.12))
                                )

                            // Title & category
                            VStack(alignment: .leading, spacing: 2) {
                                Text(habit.title)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundStyle(isDone ? .secondary : .primary)
                                    .strikethrough(isDone, color: .secondary.opacity(0.5))

                                Text(habit.category)
                                    .font(.caption2)
                                    .foregroundStyle(habit.color)
                            }

                            Spacer()

                            // Checkbox Button
                            ZStack {
                                Circle()
                                    .fill(isDone ? habit.color : Color.primary.opacity(0.06))
                                    .frame(width: 26, height: 26)

                                if isDone {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 11, weight: .bold))
                                        .foregroundStyle(.white)
                                } else {
                                    Circle()
                                        .stroke(Color.primary.opacity(0.20), lineWidth: 1.5)
                                        .frame(width: 24, height: 24)
                                }
                            }
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(isDone ? habit.color.opacity(0.06) : Color(uiColor: .tertiarySystemGroupedBackground))
                        )
                    }
                    .buttonStyle(.plain)
                }
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
    DailyHabitsCardView()
        .padding()
}
