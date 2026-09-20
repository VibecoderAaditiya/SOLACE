import SwiftUI

struct OrganicBreathCircleView: View {
    let scale: CGFloat
    private let sageColor = Color(red: 0.35, green: 0.52, blue: 0.42)

    var body: some View {
        ZStack {
            // Outer Ambient Glow Aura
            Circle()
                .fill(sageColor.opacity(0.12))
                .scaleEffect(scale * 1.35)
                .blur(radius: 25)

            // Middle Wave Ring
            Circle()
                .fill(sageColor.opacity(0.22))
                .scaleEffect(scale * 1.15)
                .blur(radius: 10)

            // Inner Soft Core Ring
            Circle()
                .fill(sageColor.opacity(0.38))
                .scaleEffect(scale)
                .shadow(color: sageColor.opacity(0.2), radius: 12, x: 0, y: 6)
        }
        .frame(width: 180, height: 180)
    }
}
