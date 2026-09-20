import SwiftUI

@main
struct SolaceApp: App {
    @AppStorage("selectedAppearance") private var selectedAppearance: Int = 0
    @State private var splashFinished: Bool = false

    var body: some Scene {
        WindowGroup {
            SplashScreenView(isFinished: $splashFinished) {
                MainTabView()
            }
            .preferredColorScheme(currentColorScheme)
        }
    }

    private var currentColorScheme: ColorScheme? {
        switch selectedAppearance {
        case 1: return .light
        case 2: return .dark
        default: return nil
        }
    }
}
