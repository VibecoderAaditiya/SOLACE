//
//  BreathingExerciseView.swift
//  SOLACE
//
//  Created by Aaditiya Pratap Singh on 30/08/26.
//


import SwiftUI

struct BreathingExerciseView: View {
    @Environment(\.dismiss) private var dismiss
    
    // Breathing Phase States
    @State private var phaseText: String = "Prepare..."
    @State private var circleScale: CGFloat = 0.6
    @State private var secondsRemaining: Int = 4
    @State private var timer: Timer? = nil

    private let sageColor = Color(red: 0.35, green: 0.52, blue: 0.42)

    var body: some View {
        ZStack {
            // Background Canvas
            Color(red: 0.97, green: 0.97, blue: 0.96)
                .ignoresSafeArea()

            VStack(spacing: 40) {
                // Top Close Button
                HStack {
                    Spacer()
                    Button {
                        stopBreathing()
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.horizontal, 24)

                Spacer()

                // Integrated Organic Breath Visualizer
                ZStack {
                    OrganicBreathCircleView(scale: circleScale)

                    VStack(spacing: 8) {
                        Text(phaseText)
                            .font(.system(size: 22, weight: .medium, design: .serif))
                            .foregroundStyle(Color(red: 0.12, green: 0.16, blue: 0.14))

                        Text("\(secondsRemaining)s")
                            .font(.system(size: 16, weight: .light, design: .monospaced))
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()

                // Guidance Subtitle
                Text("Focus on the expanding and contracting rhythm.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 32)
            }
        }
        .onAppear {
            startBreathingCycle()
        }
        .onDisappear {
            stopBreathing()
        }
    }

    private func startBreathingCycle() {
        runInhalePhase()
    }

    private func runInhalePhase() {
        phaseText = "Inhale"
        secondsRemaining = 4
        
        // Softly expand circle
        withAnimation(.easeInOut(duration: 4.0)) {
            circleScale = 1.3
        }

        startPhaseTimer(duration: 4) {
            runHoldPhase()
        }
    }

    private func runHoldPhase() {
        phaseText = "Hold"
        secondsRemaining = 4

        startPhaseTimer(duration: 4) {
            runExhalePhase()
        }
    }

    private func runExhalePhase() {
        phaseText = "Exhale"
        secondsRemaining = 4

        // Softly contract circle
        withAnimation(.easeInOut(duration: 4.0)) {
            circleScale = 0.6
        }

        startPhaseTimer(duration: 4) {
            runInhalePhase()
        }
    }

    private func startPhaseTimer(duration: Int, onComplete: @escaping () -> Void) {
        timer?.invalidate()
        var current = duration

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            current -= 1
            secondsRemaining = current

            if current <= 0 {
                timer?.invalidate()
                onComplete()
            }
        }
    }

    private func stopBreathing() {
        timer?.invalidate()
        timer = nil
    }
}