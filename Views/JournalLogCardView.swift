import SwiftUI

struct JournalLogCardView: View {
    let entry: JournalEntry
    @State private var isPressed = false

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            if let mood = entry.mood {
                let colors = moodColor(for: mood)
                Image(systemName: mood.icon)
                    .font(.title3)
                    .foregroundStyle(colors.0)
                    .frame(width: 44, height: 44)
                    .background(Circle().fill(colors.0.opacity(0.14)))
            } else {
                Image(systemName: "book.pages.fill")
                    .font(.title3)
                    .foregroundStyle(Color(red: 0.25, green: 0.55, blue: 0.45))
                    .frame(width: 44, height: 44)
                    .background(Circle().fill(Color(red: 0.25, green: 0.55, blue: 0.45).opacity(0.14)))
            }

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(entry.mood?.title ?? "Journal Note")
                        .font(.headline)
                        .foregroundStyle(.primary)

                    Spacer()

                    Text(entry.date.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }

                Text(entry.text)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)

                if !entry.tags.isEmpty {
                    HStack(spacing: 6) {
                        ForEach(entry.tags, id: \.self) { tag in
                            Text("#\(tag)")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundStyle(Color(red: 0.25, green: 0.55, blue: 0.45))
                                .padding(.horizontal, 7)
                                .padding(.vertical, 2)
                                .background(Capsule().fill(Color(red: 0.25, green: 0.55, blue: 0.45).opacity(0.10)))
                        }
                    }
                    .padding(.top, 2)
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(uiColor: .secondarySystemGroupedBackground))
                .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 3)
        )
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.easeInOut(duration: 0.15), value: isPressed)
    }

    private func moodColor(for mood: Mood) -> (Color, Color) {
        switch mood {
        case .happy:   return (Color(red: 0.95, green: 0.68, blue: 0.22), Color(red: 0.90, green: 0.48, blue: 0.15))
        case .sad:     return (Color(red: 0.38, green: 0.58, blue: 0.82), Color(red: 0.22, green: 0.40, blue: 0.68))
        case .angry:   return (Color(red: 0.92, green: 0.42, blue: 0.36), Color(red: 0.78, green: 0.26, blue: 0.22))
        case .neutral: return (Color(red: 0.42, green: 0.68, blue: 0.56), Color(red: 0.22, green: 0.48, blue: 0.38))
        case .excited: return (Color(red: 0.95, green: 0.48, blue: 0.56), Color(red: 0.86, green: 0.28, blue: 0.46))
        case .anxious: return (Color(red: 0.65, green: 0.52, blue: 0.86), Color(red: 0.48, green: 0.32, blue: 0.74))
        }
    }
}

#Preview {
    JournalLogCardView(entry: .sample)
        .padding()
        .background(Color(uiColor: .systemGroupedBackground))
}
