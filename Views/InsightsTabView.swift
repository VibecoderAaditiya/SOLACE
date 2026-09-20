import SwiftUI

// MARK: - Insights Tab View
struct InsightsTabView: View {
    private let sageColor = Color(red: 0.15, green: 0.30, blue: 0.25)

    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 18) {
                        // 1. Weekly Mindful Narrative Card
                        WeeklyTakeawayCard()

                        // 2. Mood Analytics Chart (Full weekly trend)
                        MoodAnalyticsCardView()

                        // 3. Activity Boosters & Triggers Matrix
                        MoodTriggersCard()

                        // 4. Streak Tracker Card
                        StreakCard()

                        // 5. Time of Day Rhythm
                        TimeOfDayRhythmCard()

                        // 6. Mood Distribution (Color-coded)
                        MoodDistributionCard()

                        // 7. Journal Engagement Stats
                        JournalStatsCard()
                    }
                    .padding(16)
                    .padding(.bottom, 120) // space for tab bar
                }
            }
            .navigationTitle("Insights")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

// MARK: - Weekly AI / Mindful Takeaway Card
struct WeeklyTakeawayCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: "sparkles")
                        .font(.caption.bold())
                    Text("Weekly Mindful Takeaway")
                        .font(.caption.bold())
                        .textCase(.uppercase)
                        .tracking(1)
                }
                .foregroundStyle(Color(red: 0.88, green: 0.45, blue: 0.35))

                Spacer()

                Text("Sept 7 – 13")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Text("“You recorded your highest calm scores following morning breath sessions. Nature walks and evening tea showed the strongest correlation with low anxiety.”")
                .font(.system(.subheadline, design: .serif))
                .foregroundStyle(.primary)
                .lineSpacing(3)

            HStack(spacing: 8) {
                Label("24 Mindful Mins", systemImage: "timer")
                    .font(.caption2.bold())
                    .foregroundStyle(Color(red: 0.25, green: 0.55, blue: 0.42))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Capsule().fill(Color(red: 0.25, green: 0.55, blue: 0.42).opacity(0.12)))

                Label("+18% Calm", systemImage: "arrow.up.right")
                    .font(.caption2.bold())
                    .foregroundStyle(Color(red: 0.25, green: 0.50, blue: 0.80))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Capsule().fill(Color(red: 0.25, green: 0.50, blue: 0.80).opacity(0.12)))
            }
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.98, green: 0.93, blue: 0.90),
                            Color(uiColor: .secondarySystemGroupedBackground)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 4)
        )
    }
}

// MARK: - Mood Triggers & Boosters Card
struct MoodTriggersCard: View {
    struct TriggerItem: Identifiable {
        let id = UUID()
        let emoji: String
        let title: String
        let impact: String
        let color: Color
    }

    private let triggers: [TriggerItem] = [
        TriggerItem(emoji: "🌲", title: "Nature Walk", impact: "+84% Calm", color: Color(red: 0.25, green: 0.58, blue: 0.42)),
        TriggerItem(emoji: "🧘", title: "4-7-8 Breathing", impact: "+91% Ease", color: Color(red: 0.20, green: 0.52, blue: 0.75)),
        TriggerItem(emoji: "🏃", title: "Morning Run", impact: "+76% Energy", color: Color(red: 0.92, green: 0.50, blue: 0.30)),
        TriggerItem(emoji: "☕", title: "Evening Tea", impact: "+68% Centered", color: Color(red: 0.75, green: 0.45, blue: 0.65))
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Top Wellness Boosters")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)
                        .tracking(1)

                    Text("Activities Correlated with High Well-Being")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(triggers) { item in
                    HStack(spacing: 10) {
                        Text(item.emoji)
                            .font(.title3)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(item.title)
                                .font(.caption.bold())
                                .foregroundStyle(.primary)

                            Text(item.impact)
                                .font(.caption2.bold())
                                .foregroundStyle(item.color)
                        }

                        Spacer()
                    }
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(item.color.opacity(0.08))
                    )
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(uiColor: .secondarySystemGroupedBackground))
                .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 4)
        )
    }
}

// MARK: - Time of Day Rhythm Card
struct TimeOfDayRhythmCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Daily Mood Rhythm")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .tracking(1)

            HStack(spacing: 10) {
                RhythmColumn(time: "Morning", icon: "sun.horizon.fill", mood: "Peaceful", percent: 78, color: Color(red: 0.95, green: 0.65, blue: 0.20))
                RhythmColumn(time: "Afternoon", icon: "sun.max.fill", mood: "Focused", percent: 68, color: Color(red: 0.28, green: 0.60, blue: 0.75))
                RhythmColumn(time: "Evening", icon: "moon.stars.fill", mood: "Relaxed", percent: 84, color: Color(red: 0.58, green: 0.45, blue: 0.80))
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(uiColor: .secondarySystemGroupedBackground))
                .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 4)
        )
    }
}

struct RhythmColumn: View {
    let time: String
    let icon: String
    let mood: String
    let percent: Int
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.headline)
                .foregroundStyle(color)

            Text(time)
                .font(.caption2.bold())
                .foregroundStyle(.secondary)

            ZStack {
                Circle()
                    .stroke(color.opacity(0.15), lineWidth: 4)
                    .frame(width: 44, height: 44)

                Circle()
                    .trim(from: 0, to: CGFloat(percent) / 100)
                    .stroke(color, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(width: 44, height: 44)

                Text("\(percent)%")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(.primary)
            }

            Text(mood)
                .font(.caption2.bold())
                .foregroundStyle(color)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(color.opacity(0.05))
        )
    }
}

// MARK: - Streak Card
struct StreakCard: View {
    private let sageColor = Color(red: 0.22, green: 0.52, blue: 0.40)
    let streakDays = ["M", "T", "W", "T", "F", "S", "S"]
    let completedDays = [true, true, true, true, true, true, false]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Check-in Streak")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)
                        .tracking(1)

                    Text("6 Days Strong 🔥")
                        .font(.headline)
                        .foregroundStyle(.primary)
                }
                Spacer()
                Text("This Week")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Capsule().fill(Color.primary.opacity(0.06)))
            }

            HStack(spacing: 8) {
                ForEach(Array(zip(streakDays, completedDays)), id: \.0) { day, completed in
                    VStack(spacing: 8) {
                        ZStack {
                            Circle()
                                .fill(completed ? sageColor : Color.primary.opacity(0.06))
                                .frame(width: 36, height: 36)

                            if completed {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                        }
                        Text(day)
                            .font(.caption2)
                            .fontWeight(.medium)
                            .foregroundStyle(completed ? sageColor : .secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(uiColor: .secondarySystemGroupedBackground))
                .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 4)
        )
    }
}

// MARK: - Mood Distribution Card
struct MoodDistributionCard: View {
    private let moods: [(Mood, Int, Color)] = [
        (.happy, 8, Color(red: 0.95, green: 0.68, blue: 0.22)),
        (.neutral, 5, Color(red: 0.42, green: 0.68, blue: 0.56)),
        (.anxious, 4, Color(red: 0.65, green: 0.52, blue: 0.86)),
        (.excited, 3, Color(red: 0.95, green: 0.48, blue: 0.56)),
        (.sad, 2, Color(red: 0.38, green: 0.58, blue: 0.82)),
        (.angry, 1, Color(red: 0.92, green: 0.42, blue: 0.36))
    ]

    private var total: Int { moods.reduce(0) { $0 + $1.1 } }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Mood Distribution")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .tracking(1)

            Text("Last 30 Days")
                .font(.headline)
                .foregroundStyle(.primary)

            VStack(spacing: 12) {
                ForEach(moods, id: \.0) { mood, count, color in
                    HStack(spacing: 12) {
                        Image(systemName: mood.icon)
                            .font(.body)
                            .foregroundStyle(color)
                            .frame(width: 24)

                        Text(mood.title)
                            .font(.subheadline)
                            .foregroundStyle(.primary)
                            .frame(width: 65, alignment: .leading)

                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(Color.primary.opacity(0.06))
                                    .frame(height: 8)

                                Capsule()
                                    .fill(color)
                                    .frame(width: geo.size.width * CGFloat(count) / CGFloat(total), height: 8)
                                    .animation(.easeOut(duration: 0.8), value: count)
                            }
                        }
                        .frame(height: 8)

                        Text("\(count)")
                            .font(.caption.bold())
                            .foregroundStyle(.secondary)
                            .frame(width: 24, alignment: .trailing)
                    }
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(uiColor: .secondarySystemGroupedBackground))
                .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 4)
        )
    }
}

// MARK: - Journal Stats Card
struct JournalStatsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Journal Stats")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .tracking(1)

            HStack(spacing: 0) {
                StatItem(value: "23", label: "Entries", icon: "doc.text.fill", color: Color(red: 0.25, green: 0.55, blue: 0.42))
                Divider().frame(height: 44)
                StatItem(value: "1.2k", label: "Words", icon: "textformat.abc", color: Color(red: 0.35, green: 0.55, blue: 0.80))
                Divider().frame(height: 44)
                StatItem(value: "6", label: "Day Streak", icon: "flame.fill", color: Color(red: 0.95, green: 0.55, blue: 0.25))
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(uiColor: .secondarySystemGroupedBackground))
                .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 4)
        )
    }
}

struct StatItem: View {
    let value: String
    let label: String
    let icon: String
    var color: Color = Color(red: 0.15, green: 0.30, blue: 0.25)

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)

            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.primary)

            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    InsightsTabView()
}
