import SwiftUI

// MARK: - Journal Tab View (Full Journal Screen)
struct JournalTabView: View {
    @State private var entries: [JournalEntry] = [
        JournalEntry(
            id: UUID(),
            date: Date(),
            mood: .happy,
            text: "Today I felt optimistic and peaceful. Took a slow 15-minute walk under the tall pine trees.",
            tags: ["nature", "peace"]
        ),
        JournalEntry(
            id: UUID(),
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
            mood: .excited,
            text: "Started the day with 4-7-8 breathing. Felt an immediate clarity of thought and energized focus.",
            tags: ["focus", "gratitude"]
        )
    ]
    @State private var selectedFilter: String = "all"

    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 18) {
                        // 1. On This Day / Memory Flashback Card
                        MemoryFlashbackCard()

                        // 2. Interactive Quick Entry Card
                        JournalQuickEntryView { text, mood, tags in
                            let entry = JournalEntry(
                                id: UUID(),
                                date: Date(),
                                mood: mood,
                                text: text,
                                tags: tags
                            )
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                                entries.insert(entry, at: 0)
                            }
                        }

                        // 3. Past Entries with Filter
                        if !entries.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Text("Reflections Feed")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.secondary)
                                        .textCase(.uppercase)
                                        .tracking(1)

                                    Spacer()

                                    Text("\(entries.count) entries")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.horizontal, 4)

                                ForEach(entries) { entry in
                                    JournalLogCardView(entry: entry)
                                }
                            }
                        }
                    }
                    .padding(16)
                    .padding(.bottom, 120) // space for tab bar
                }
            }
            .navigationTitle("Journal")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

// MARK: - Memory Flashback ("On This Day") Card
struct MemoryFlashbackCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 6) {
                Image(systemName: "sparkles")
                    .font(.caption)
                    .foregroundStyle(Color(red: 0.88, green: 0.58, blue: 0.28))

                Text("Memory Flashback")
                    .font(.caption2.bold())
                    .foregroundStyle(Color(red: 0.88, green: 0.58, blue: 0.28))
                    .textCase(.uppercase)
                    .tracking(1)

                Spacer()

                Text("1 Week Ago")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Text("\"Every breath is a fresh start to come home to yourself.\"")
                .font(.system(.subheadline, design: .serif))
                .italic()
                .foregroundStyle(.primary)
                .lineSpacing(2)

            HStack {
                Label("You noted feeling Peaceful", systemImage: "sun.max.fill")
                    .font(.caption2)
                    .foregroundStyle(Color(red: 0.35, green: 0.58, blue: 0.45))

                Spacer()

                HStack(spacing: 4) {
                    Text("#nature")
                    Text("#calm")
                }
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(.secondary)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.98, green: 0.94, blue: 0.88),
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

// Custom TextEditor placeholder wrapper
extension View {
    func textEditorPlaceholder(_ placeholder: String, text: Binding<String>) -> some View {
        ZStack(alignment: .topLeading) {
            if text.wrappedValue.isEmpty {
                Text(placeholder)
                    .foregroundStyle(.tertiary)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 20)
            }
            self
        }
    }
}

#Preview {
    JournalTabView()
}
