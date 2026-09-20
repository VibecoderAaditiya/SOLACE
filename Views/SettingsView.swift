import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedAppearance") private var selectedAppearance: Int = 0
    @AppStorage("showMoodPrompt") private var showMoodPrompt: Bool = true
    @AppStorage("hapticsEnabled") private var hapticsEnabled: Bool = true

    private let sageColor = Color(red: 0.15, green: 0.30, blue: 0.25)

    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()

                List {
                    // App Appearance
                    Section {
                        VStack(alignment: .leading, spacing: 10) {
                            Label("Theme", systemImage: "moon.fill")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(.primary)
                            Picker("", selection: $selectedAppearance) {
                                Text("System").tag(0)
                                Text("Light").tag(1)
                                Text("Dark").tag(2)
                            }
                            .pickerStyle(.segmented)
                        }
                        .padding(.vertical, 4)
                    } header: {
                        Text("Appearance")
                    }

                    // Wellness Settings
                    Section("Wellness") {
                        Toggle(isOn: $showMoodPrompt) {
                            Label("Mood Prompt", systemImage: "bubble.left.and.text.bubble.right.fill")
                        }
                        .tint(sageColor)

                        Toggle(isOn: $hapticsEnabled) {
                            Label("Haptic Feedback", systemImage: "hand.tap.fill")
                        }
                        .tint(sageColor)
                    }

                    // About
                    Section("About") {
                        HStack {
                            Label("Version", systemImage: "info.circle.fill")
                            Spacer()
                            Text("1.0.0")
                                .foregroundStyle(.secondary)
                        }

                        HStack {
                            Label("Made with", systemImage: "heart.fill")
                                .symbolRenderingMode(.multicolor)
                            Spacer()
                            Text("🌿 SOLACE")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    SettingsView()
}
