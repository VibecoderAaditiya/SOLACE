import SwiftUI

struct SplashScreenView<Content: View>: View {
    @Binding var isFinished: Bool
    @ViewBuilder let mainContent: Content

    // 1. Leaf Physics & Drop States
    @State private var leafOffsetY: CGFloat = -80
    @State private var leafOpacity: Double = 0.0
    @State private var leafScale: CGFloat = 0.5
    @State private var leafRotation: Double = -12.0

    // 2. Multi-Tiered Water Ripples
    @State private var ripple1Scale: CGFloat = 0.2
    @State private var ripple1Opacity: Double = 0.0

    @State private var ripple2Scale: CGFloat = 0.2
    @State private var ripple2Opacity: Double = 0.0

    @State private var ripple3Scale: CGFloat = 0.2
    @State private var ripple3Opacity: Double = 0.0

    // 3. Ambient Lighting & Typography
    @State private var titleOpacity: Double = 0.0
    @State private var titleOffsetY: CGFloat = 20
    @State private var lightGleamOpacity: Double = 0.0

    // 4. Drone Camera Flight & Portal States
    @State private var portalScale: CGFloat = 1.0
    @State private var isFlyingThrough: Bool = false
    @State private var appZoomScale: CGFloat = 1.18
    @State private var appOpacity: Double = 0.0
    @State private var appBlurRadius: CGFloat = 8.0
    @State private var splashCanvasOpacity: Double = 1.0

    // Color Palette
    private let sageColor = Color(red: 0.35, green: 0.52, blue: 0.42)
    private let deepSage = Color(red: 0.22, green: 0.36, blue: 0.28)
    private let offWhite = Color(red: 0.97, green: 0.97, blue: 0.96)
    private let darkTitleColor = Color(red: 0.12, green: 0.16, blue: 0.14)

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Layer 1: The Main App World (Unfocused during flight)
                mainContent
                    .scaleEffect(appZoomScale)
                    .opacity(appOpacity)
                    .blur(radius: appBlurRadius)

                // Layer 2: Splash Canvas Overlay
                if splashCanvasOpacity > 0 {
                    ZStack {
                        // Ambient Off-White Canvas
                        offWhite
                            .ignoresSafeArea()

                        // Soft Background Ambient Radial Lighting
                        RadialGradient(
                            colors: [sageColor.opacity(0.12), Color.clear],
                            center: .center,
                            startRadius: 20,
                            endRadius: 280
                        )
                        .opacity(lightGleamOpacity)
                        .ignoresSafeArea()

                        // Concentric Water Ripples
                        ZStack {
                            // Primary Ripple Wave
                            Circle()
                                .stroke(sageColor.opacity(0.35), lineWidth: 1.5)
                                .scaleEffect(ripple1Scale)
                                .opacity(ripple1Opacity)

                            // Secondary Ripple Wave
                            Circle()
                                .stroke(sageColor.opacity(0.22), lineWidth: 1.2)
                                .scaleEffect(ripple2Scale)
                                .opacity(ripple2Opacity)

                            // Tertiary Soft Outer Wave
                            Circle()
                                .stroke(sageColor.opacity(0.12), lineWidth: 1.0)
                                .scaleEffect(ripple3Scale)
                                .opacity(ripple3Opacity)
                        }
                        .frame(width: 140, height: 140)

                        // Calligraphy Title & Subtitle
                        VStack(spacing: 8) {
                            Text("SOLACE")
                                .font(.system(size: 42, weight: .bold, design: .serif))
                                .tracking(10)
                                .foregroundStyle(darkTitleColor)

                            Text("A silent place")
                                .font(.system(size: 13, weight: .medium, design: .serif))
                                .italic()
                                .tracking(4)
                                .foregroundStyle(darkTitleColor.opacity(0.6))
                        }
                        .offset(y: titleOffsetY)
                        .opacity(titleOpacity)

                        // Initial Floating Leaf Icon
                        if !isFlyingThrough {
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 58, weight: .light))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [sageColor, deepSage],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .rotationEffect(.degrees(leafRotation))
                                .scaleEffect(leafScale)
                                .offset(y: leafOffsetY)
                                .opacity(leafOpacity)
                                .shadow(color: sageColor.opacity(0.22), radius: 12, x: 0, y: 6)
                        }
                    }
                    .opacity(splashCanvasOpacity)
                    // Inverted Leaf Cutout Window Mask
                    .mask(
                        ZStack {
                            if isFlyingThrough {
                                Rectangle()
                                    .fill(Color.black)
                                    .ignoresSafeArea()

                                Image(systemName: "leaf.fill")
                                    .font(.system(size: 58, weight: .light))
                                    .offset(y: leafOffsetY)
                                    .scaleEffect(portalScale)
                                    .blendMode(.destinationOut) // Cuts out leaf aperture window
                            } else {
                                Rectangle()
                                    .fill(Color.black)
                                    .ignoresSafeArea()
                            }
                        }
                        .compositingGroup()
                    )
                }
            }
        }
        .onAppear {
            runUltraDroneFlightAnimation()
        }
    }

    private func runUltraDroneFlightAnimation() {
        // Step 1: Leaf gently floats down with subtle natural sway
        withAnimation(.spring(response: 1.2, dampingFraction: 0.72)) {
            leafOffsetY = -15
            leafOpacity = 1.0
            leafScale = 1.0
            leafRotation = 0.0
        }

        // Step 2: Staggered multi-wave water ripples expand outward
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
            SoundManager.playSound(named: "water_drop.mp3", volume: 0.4)

            // Ambient background light swell
            withAnimation(.easeInOut(duration: 1.2)) {
                lightGleamOpacity = 1.0
            }

            // Ripple Wave 1
            withAnimation(.easeOut(duration: 1.8)) {
                ripple1Scale = 2.8
                ripple1Opacity = 0.75
            }
            withAnimation(.easeOut(duration: 0.8).delay(1.0)) {
                ripple1Opacity = 0.0
            }

            // Ripple Wave 2
            withAnimation(.easeOut(duration: 2.1).delay(0.25)) {
                ripple2Scale = 3.5
                ripple2Opacity = 0.5
            }
            withAnimation(.easeOut(duration: 0.8).delay(1.3)) {
                ripple2Opacity = 0.0
            }

            // Ripple Wave 3
            withAnimation(.easeOut(duration: 2.4).delay(0.45)) {
                ripple3Scale = 4.2
                ripple3Opacity = 0.28
            }
            withAnimation(.easeOut(duration: 0.8).delay(1.5)) {
                ripple3Opacity = 0.0
            }
        }

        // Step 3: Unveil Calligraphy Title
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            withAnimation(.easeInOut(duration: 1.0)) {
                titleOpacity = 1.0
                titleOffsetY = 65
            }
        }

        // Step 4: Cinematic Drone Flight Through Leaf Portal
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
            SoundManager.playSound(named: "portal_whoosh.mp3", volume: 0.25)

            // Fade title out right before flight
            withAnimation(.easeOut(duration: 0.3)) {
                titleOpacity = 0.0
            }

            isFlyingThrough = true

            // Portal fly-through with depth-blur pull
            withAnimation(.spring(response: 1.4, dampingFraction: 0.85)) {
                portalScale = 200.0
                appZoomScale = 1.0
                appOpacity = 1.0
                appBlurRadius = 0.0
            }

            // Dissolve residual canvas at the end of camera sweep
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.15) {
                withAnimation(.easeOut(duration: 0.35)) {
                    splashCanvasOpacity = 0.0
                }
            }

            // Complete transition and remove splash from view hierarchy
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.55) {
                isFinished = true
            }
        }
    }
}
