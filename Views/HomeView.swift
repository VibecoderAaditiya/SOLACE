import SwiftUI

struct HomeView: View {
    @State private var greeting: String = ""
    var onNavigateToJournal: (() -> Void)? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 18) {
                        // Greeting Header
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(greeting)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Text("How are you feeling?")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.primary)
                            }
                            Spacer()
                            // Colorful Leaf Icon Badge
                            Image(systemName: "leaf.fill")
                                .font(.title3)
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [Color(red: 0.35, green: 0.65, blue: 0.45), Color(red: 0.15, green: 0.45, blue: 0.30)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .padding(12)
                                .background(
                                    Circle()
                                        .fill(Color(red: 0.35, green: 0.65, blue: 0.45).opacity(0.14))
                                )
                        }
                        .padding(.horizontal, 4)

                        // 1. Colorful Mood Tracker
                        MoodTrackerView()

                        // 2. Daily Micro-Rituals Checklist
                        DailyHabitsCardView()

                        // 3. Ambient Soundscapes Carousel
                        AmbientSoundscapesCardView()

                        // 4. Instant Grounding Tactile Pebble
                        CalmPebbleWidgetView()

                        // 5. Daily Reflection Prompt Card
                        DailyPromptCardView {
                            onNavigateToJournal?()
                        }

                        // 6. Inspirational Wisdom Card
                        InspirationalQuoteView()

                        // 7. Weekly Mood Analytics Preview
                        MoodAnalyticsCardView()
                    }
                    .padding(16)
                    .padding(.bottom, 120) // space for tab bar & floating sound player
                }
            }
            .navigationTitle("SOLACE")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("SOLACE")
                        .font(.system(size: 18, weight: .bold, design: .serif))
                        .tracking(4)
                        .foregroundStyle(Color(red: 0.15, green: 0.35, blue: 0.28))
                }
            }
        }
        .onAppear {
            greeting = timeGreeting()
        }
    }

    private func timeGreeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12:  return "Good morning 🌅"
        case 12..<17: return "Good afternoon ☀️"
        case 17..<21: return "Good evening 🌇"
        default:      return "Good night 🌙"
        }
    }
}

#Preview {
    HomeView()
}
