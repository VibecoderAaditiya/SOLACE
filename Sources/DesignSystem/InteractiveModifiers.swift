// Sources/DesignSystem/InteractiveModifiers.swift
import SwiftUI
import CoreHaptics

extension View {
    /// Adds a subtle ripple effect on tap. The ripple expands and fades quickly.
    @ViewBuilder
    func rippleEffect(isActive: Bool) -> some View {
        if isActive {
            self.overlay(
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                    .scaleEffect(1.5)
                    .opacity(0)
                    .animation(.easeOut(duration: 0.4), value: isActive)
            )
        } else {
            self
        }
    }
    
    /// Triggers a light haptic feedback when the view is tapped.
    func hapticTap() -> some View {
        self.onTapGesture {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }
}
