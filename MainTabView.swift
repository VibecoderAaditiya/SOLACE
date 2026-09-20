import SwiftUI

// MARK: - Tab Definition
enum SolaceTab: Int, CaseIterable {
    case home = 0
    case breathe = 1
    case journal = 2
    case insights = 3
    case settings = 4

    var emoji: String {
        switch self {
        case .home:     return "🌿"
        case .breathe:  return "🌬️"
        case .journal:  return "📖"
        case .insights: return "📊"
        case .settings: return "⚙️"
        }
    }

    var label: String {
        switch self {
        case .home:     return "Home"
        case .breathe:  return "Breathe"
        case .journal:  return "Journal"
        case .insights: return "Insights"
        case .settings: return "Settings"
        }
    }

    var accentColor: Color {
        switch self {
        case .home:     return Color(red: 0.20, green: 0.52, blue: 0.36)
        case .breathe:  return Color(red: 0.18, green: 0.55, blue: 0.68)
        case .journal:  return Color(red: 0.82, green: 0.42, blue: 0.52)
        case .insights: return Color(red: 0.90, green: 0.58, blue: 0.20)
        case .settings: return Color(red: 0.52, green: 0.45, blue: 0.72)
        }
    }
}

// MARK: - Main Tab View
struct MainTabView: View {
    @State private var selectedTab: SolaceTab = .insights
    @Namespace private var tabAnimation
    @ObservedObject private var soundManager = AmbientSoundManager.shared

    var body: some View {
        ZStack(alignment: .bottom) {
            // MARK: Tab Content
            Group {
                switch selectedTab {
                case .home:
                    HomeView {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                            selectedTab = .journal
                        }
                    }
                case .breathe:
                    BreatheTabView()
                case .journal:
                    JournalTabView()
                case .insights:
                    InsightsTabView()
                case .settings:
                    SettingsView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // MARK: Bottom Floating Elements
            VStack(spacing: 8) {
                // Floating Ambient Sound Player Bar
                if let track = soundManager.currentTrack {
                    FloatingSoundBar(track: track)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }

                // Custom Tab Bar
                CustomTabBar(selectedTab: $selectedTab, tabAnimation: tabAnimation)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .animation(.spring(response: 0.4, dampingFraction: 0.75), value: soundManager.currentTrack)
    }
}

// MARK: - Floating Ambient Sound Bar
struct FloatingSoundBar: View {
    let track: AmbientTrack
    @ObservedObject private var soundManager = AmbientSoundManager.shared

    var body: some View {
        HStack(spacing: 12) {
            Text(track.emoji)
                .font(.title3)

            VStack(alignment: .leading, spacing: 1) {
                Text(track.title)
                    .font(.caption.bold())
                    .foregroundStyle(.primary)

                Text(soundManager.isPlaying ? "Playing soundscape" : "Paused")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            // Play / Pause Button
            Button {
                if soundManager.isPlaying {
                    soundManager.pause()
                } else {
                    soundManager.play(track)
                }
            } label: {
                Image(systemName: soundManager.isPlaying ? "pause.fill" : "play.fill")
                    .font(.caption.bold())
                    .foregroundStyle(.white)
                    .frame(width: 32, height: 32)
                    .background(
                        Circle()
                            .fill(track.colors.first ?? .teal)
                    )
            }

            // Close / Stop Button
            Button {
                soundManager.stop()
            } label: {
                Image(systemName: "xmark")
                    .font(.caption2.bold())
                    .foregroundStyle(.secondary)
                    .padding(6)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(.ultraThinMaterial)
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .stroke(Color.primary.opacity(0.08), lineWidth: 1)
            }
            .shadow(color: Color.black.opacity(0.08), radius: 14, x: 0, y: 4)
        )
        .padding(.horizontal, 20)
    }
}

// MARK: - Custom Tab Bar
struct CustomTabBar: View {
    @Binding var selectedTab: SolaceTab
    var tabAnimation: Namespace.ID

    var body: some View {
        HStack(spacing: 0) {
            ForEach(SolaceTab.allCases, id: \.self) { tab in
                TabBarButton(
                    tab: tab,
                    isSelected: selectedTab == tab,
                    tabAnimation: tabAnimation
                ) {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.70)) {
                        selectedTab = tab
                    }
                    SolaceHaptics.pulse()
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.top, 10)
        .padding(.bottom, 4)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(.ultraThinMaterial)

                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .stroke(Color.primary.opacity(0.08), lineWidth: 1)
            }
            .shadow(color: Color.black.opacity(0.10), radius: 20, x: 0, y: -4)
        )
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
}

// MARK: - Tab Bar Button
struct TabBarButton: View {
    let tab: SolaceTab
    let isSelected: Bool
    var tabAnimation: Namespace.ID
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                ZStack {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(tab.accentColor.opacity(0.15))
                            .frame(width: 48, height: 36)
                            .matchedGeometryEffect(id: "TAB_BG", in: tabAnimation)
                    }

                    Text(tab.emoji)
                        .font(.system(size: isSelected ? 24 : 20))
                        .scaleEffect(isSelected ? 1.1 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
                }
                .frame(height: 36)

                Text(tab.label)
                    .font(.system(size: 10, weight: isSelected ? .bold : .regular))
                    .foregroundStyle(isSelected ? tab.accentColor : Color.secondary.opacity(0.7))
                    .animation(.easeInOut(duration: 0.2), value: isSelected)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    MainTabView()
}
