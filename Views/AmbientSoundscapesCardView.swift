import SwiftUI

struct AmbientSoundscapesCardView: View {
    @ObservedObject var soundManager = AmbientSoundManager.shared

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Soundscapes")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)
                        .tracking(1)

                    Text("Ambient Audio for Calm & Focus")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if let current = soundManager.currentTrack, soundManager.isPlaying {
                    HStack(spacing: 4) {
                        SoundWaveIndicator()
                        Text("Playing")
                            .font(.caption2.bold())
                            .foregroundStyle(current.colors.first ?? .teal)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill((current.colors.first ?? .teal).opacity(0.12))
                    )
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(AmbientSoundManager.availableTracks) { track in
                        let isSelected = soundManager.currentTrack?.id == track.id
                        let isPlaying = isSelected && soundManager.isPlaying

                        Button {
                            soundManager.toggleTrack(track)
                        } label: {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text(track.emoji)
                                        .font(.title2)

                                    Spacer()

                                    ZStack {
                                        Circle()
                                            .fill(Color.white.opacity(0.20))
                                            .frame(width: 28, height: 28)

                                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                            .font(.caption2)
                                            .foregroundStyle(.white)
                                    }
                                }

                                Spacer()

                                VStack(alignment: .leading, spacing: 2) {
                                    Text(track.title)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)

                                    Text(track.subtitle)
                                        .font(.caption2)
                                        .foregroundStyle(.white.opacity(0.8))
                                }
                            }
                            .padding(14)
                            .frame(width: 135, height: 110)
                            .background(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(
                                        LinearGradient(
                                            colors: track.colors,
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .shadow(
                                        color: track.colors.first?.opacity(isPlaying ? 0.35 : 0.15) ?? .clear,
                                        radius: isPlaying ? 10 : 5,
                                        x: 0,
                                        y: isPlaying ? 6 : 3
                                    )
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .stroke(Color.white.opacity(isPlaying ? 0.40 : 0.0), lineWidth: 2)
                            )
                            .scaleEffect(isPlaying ? 1.03 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isPlaying)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 2)
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

// Subtle Animated Waveform Bars
struct SoundWaveIndicator: View {
    @State private var wave: Bool = false

    var body: some View {
        HStack(spacing: 2) {
            RoundedRectangle(cornerRadius: 1)
                .frame(width: 2, height: wave ? 10 : 4)
            RoundedRectangle(cornerRadius: 1)
                .frame(width: 2, height: wave ? 5 : 12)
            RoundedRectangle(cornerRadius: 1)
                .frame(width: 2, height: wave ? 12 : 6)
        }
        .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: wave)
        .onAppear { wave = true }
    }
}

#Preview {
    AmbientSoundscapesCardView()
        .padding()
}
