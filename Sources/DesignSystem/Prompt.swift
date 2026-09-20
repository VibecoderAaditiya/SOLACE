// Sources/DesignSystem/Prompt.swift
import SwiftUI

struct Prompt {
    // MARK: - Seed prompts displayed above the journal entry field.
    static let seedPrompts = [
        "What gave you a spark today?",
        "What moment made you smile?",
        "What are you grateful for right now?",
        "Which small win are you celebrating?",
        "What intention will guide you today?"
    ]
    
    // MARK: - Mood‑aligned prompts – map a Mood to a gentle question.
    static let moodPrompts: [Mood: String] = [
        .happy: "What brightened your day?",
        .excited: "What is bringing you so much energy and joy?",
        .neutral: "What simple thing brought you comfort?",
        .sad: "What would you like to be gentle with right now?",
        .angry: "What feels heavy or frustrating right now?",
        .anxious: "What can you breathe into ease?"
    ]
    
    // MARK: - Quote of the day – a small static list.
    static let quotes = [
        "Simplicity is the ultimate sophistication. – Leonardo da Vinci",
        "Quiet the mind, and the soul will speak. – Ma Jaya Sati",
        "Peace begins with a smile. – Mother Teresa",
        "The present moment is a gift – cherish it.",
        "Breathe in calm, exhale stress."
    ]
    
    /// Returns a random seed prompt.
    static func randomSeed() -> String {
        seedPrompts.randomElement() ?? "What are you feeling?"
    }
    
    /// Returns a prompt that matches the supplied mood.
    static func forMood(_ mood: Mood) -> String {
        moodPrompts[mood] ?? "How does this feel for you?"
    }
    
    /// Returns a deterministic quote of the day based on the current calendar day.
    static func quoteOfTheDay() -> String {
        let day = Calendar.current.component(.day, from: Date())
        return quotes[day % quotes.count]
    }
}
