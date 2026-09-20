//
//  SoundManager.swift
//  SOLACE
//
//  Created by Aaditiya Pratap Singh on 01/09/26.
//

import AVFoundation
import SwiftUI
import Combine

struct SoundManager {
    static var dropPlayer: AVAudioPlayer?
    static var whooshPlayer: AVAudioPlayer?

    static func playSound(named fileName: String, volume: Float = 0.5) {
        // Ensure audio plays properly even if the device silent switch is enabled
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session setup error: \(error)")
        }

        // Locate sound file in main app bundle
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            // Fails gracefully if audio files are not yet added to Xcode
            print("Sound file '\(fileName)' not found in app bundle.")
            return
        }

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.volume = volume
            player.prepareToPlay()

            if fileName.contains("drop") {
                dropPlayer = player
                dropPlayer?.play()
            } else {
                whooshPlayer = player
                whooshPlayer?.play()
            }
        } catch {
            print("Failed to play sound: \(error)")
        }
    }
}

// MARK: - Ambient Soundscapes Service
public struct AmbientTrack: Identifiable, Equatable {
    public let id: String
    public let title: String
    public let subtitle: String
    public let emoji: String
    public let colors: [Color]
    public let icon: String
}

public class AmbientSoundManager: ObservableObject {
    public static let shared = AmbientSoundManager()

    @Published public var currentTrack: AmbientTrack? = nil
    @Published public var isPlaying: Bool = false

    public static let availableTracks: [AmbientTrack] = [
        AmbientTrack(
            id: "rain",
            title: "Soft Rain",
            subtitle: "Peaceful Drizzle",
            emoji: "🌧️",
            colors: [Color(red: 0.32, green: 0.52, blue: 0.68), Color(red: 0.18, green: 0.32, blue: 0.48)],
            icon: "cloud.rain.fill"
        ),
        AmbientTrack(
            id: "forest",
            title: "Pine Forest",
            subtitle: "Canopy & Birds",
            emoji: "🌲",
            colors: [Color(red: 0.28, green: 0.58, blue: 0.42), Color(red: 0.14, green: 0.34, blue: 0.24)],
            icon: "tree.fill"
        ),
        AmbientTrack(
            id: "ocean",
            title: "Ocean Waves",
            subtitle: "Tidal Rhythms",
            emoji: "🌊",
            colors: [Color(red: 0.22, green: 0.62, blue: 0.72), Color(red: 0.12, green: 0.38, blue: 0.52)],
            icon: "water.waves"
        ),
        AmbientTrack(
            id: "bowl",
            title: "Singing Bowl",
            subtitle: "432Hz Calm",
            emoji: "🔔",
            colors: [Color(red: 0.88, green: 0.68, blue: 0.38), Color(red: 0.68, green: 0.44, blue: 0.18)],
            icon: "bell.fill"
        )
    ]

    public func toggleTrack(_ track: AmbientTrack) {
        if currentTrack?.id == track.id {
            if isPlaying {
                pause()
            } else {
                play(track)
            }
        } else {
            play(track)
        }
    }

    public func play(_ track: AmbientTrack) {
        currentTrack = track
        isPlaying = true
        SolaceHaptics.pulse()
    }

    public func pause() {
        isPlaying = false
        SolaceHaptics.pulse()
    }

    public func stop() {
        isPlaying = false
        currentTrack = nil
        SolaceHaptics.pulse()
    }
}