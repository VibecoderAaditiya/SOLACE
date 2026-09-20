import SwiftUI

struct CalmPebbleWidgetView: View {
    @State private var isPressing = false
    @State private var pulseRing = false
    @State private var holdSeconds = 0
    @State private var timer: Timer? = nil

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Instant Grounding")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)
                        .tracking(1)

                    Text("Tactile Calm Pebble")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Label("Haptic Touch", systemImage: "hand.tap.fill")
                    .font(.caption2)
                    .foregroundStyle(Color(red: 0.35, green: 0.55, blue: 0.75))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color(red: 0.35, green: 0.55, blue: 0.75).opacity(0.12))
                    )
            }

            // Interactive Pebble Button
            ZStack {
                // Expanding ripple rings when pressed
                if isPressing {
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [Color(red: 0.40, green: 0.70, blue: 0.85).opacity(0.4), Color(red: 0.80, green: 0.60, blue: 0.90).opacity(0.1)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 3
                        )
                        .frame(width: 140, height: 140)
                        .scaleEffect(pulseRing ? 1.35 : 0.9)
                        .opacity(pulseRing ? 0.0 : 0.8)
                        .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: false), value: pulseRing)
                }

                // Ambient glow circle
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color(red: 0.38, green: 0.68, blue: 0.78).opacity(isPressing ? 0.35 : 0.12),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 20,
                            endRadius: 80
                        )
                    )
                    .frame(width: 150, height: 150)

                // The Pebble
                ZStack {
                    RoundedRectangle(cornerRadius: 38, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: isPressing ? [
                                    Color(red: 0.25, green: 0.60, blue: 0.68),
                                    Color(red: 0.52, green: 0.45, blue: 0.80)
                                ] : [
                                    Color(red: 0.32, green: 0.55, blue: 0.58),
                                    Color(red: 0.45, green: 0.40, blue: 0.68)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 110, height: 76)
                        .shadow(
                            color: Color(red: 0.32, green: 0.55, blue: 0.58).opacity(isPressing ? 0.50 : 0.25),
                            radius: isPressing ? 16 : 8,
                            x: 0,
                            y: isPressing ? 6 : 4
                        )

                    // Pebble Inner Specular Highlight
                    RoundedRectangle(cornerRadius: 38, style: .continuous)
                        .stroke(
                            LinearGradient(
                                colors: [Color.white.opacity(0.6), Color.white.opacity(0.0)],
                                startPoint: .top,
                                endPoint: .bottom
                            ),
                            lineWidth: 1.5
                        )
                        .frame(width: 110, height: 76)

                    VStack(spacing: 3) {
                        Image(systemName: isPressing ? "sparkles" : "hand.point.up.fill")
                            .font(.system(size: 20, weight: .light))
                            .foregroundStyle(.white)

                        Text(isPressing ? "Grounding..." : "Hold Pebble")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                }
                .scaleEffect(isPressing ? 0.94 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressing)
            }
            .frame(height: 120)
            .contentShape(Rectangle())
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isPressing {
                            startPress()
                        }
                    }
                    .onEnded { _ in
                        endPress()
                    }
            )

            // Instruction subtitle
            Text(isPressing ? "Breathe slowly with the vibration. You are anchored." : "Press & hold with your thumb whenever feeling overwhelmed")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(uiColor: .secondarySystemGroupedBackground))
                .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
        )
    }

    private func startPress() {
        isPressing = true
        pulseRing = true
        holdSeconds = 0
        SolaceHaptics.heartbeat()

        timer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true) { _ in
            holdSeconds += 1
            SolaceHaptics.pulse()
        }
    }

    private func endPress() {
        isPressing = false
        pulseRing = false
        timer?.invalidate()
        timer = nil
        SolaceHaptics.success()
    }
}

#Preview {
    CalmPebbleWidgetView()
        .padding()
}
