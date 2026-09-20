import Foundation
import SwiftUI

enum Mood: String, Codable, CaseIterable, Equatable {
    case happy, sad, angry, neutral, excited, anxious

    var title: String {
        switch self {
        case .happy: return "Happy"
        case .sad: return "Sad"
        case .angry: return "Angry"
        case .neutral: return "Okay"
        case .excited: return "Excited"
        case .anxious: return "Anxious"
        }
    }

    var icon: String {
        switch self {
        case .happy: return "sun.max.fill"
        case .sad: return "cloud.rain.fill"
        case .angry: return "flame.fill"
        case .neutral: return "circle.fill"
        case .excited: return "sparkles"
        case .anxious: return "moon.stars.fill"
        }
    }
}

struct JournalEntry: Identifiable, Codable, Equatable {
    let id: UUID
    let date: Date
    let mood: Mood?
    let text: String
    var tags: [String] = []

    init(id: UUID = UUID(), date: Date = Date(), mood: Mood? = nil, text: String, tags: [String] = []) {
        self.id = id
        self.date = date
        self.mood = mood
        self.text = text
        self.tags = tags
    }
}

extension JournalEntry {
    static let sample = JournalEntry(
        id: UUID(),
        date: Date(),
        mood: .happy,
        text: "Today I felt optimistic and peaceful. Took a 15-minute walk under the tall pine trees.",
        tags: ["nature", "peace"]
    )
}
