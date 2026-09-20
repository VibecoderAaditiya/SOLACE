//
//  IconPreview.swift
//  SOLACE
//
//  Created by Aaditiya Pratap Singh on 01/09/26.
//


import SwiftUI

struct IconPreview: View {
    private let sageColor = Color(red: 0.35, green: 0.52, blue: 0.42)
    private let deepSage = Color(red: 0.28, green: 0.44, blue: 0.35)

    var body: some View {
        ZStack {
            // Sage Gradient
            LinearGradient(
                colors: [sageColor, deepSage],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            // Center White Leaf Symbol
            Image(systemName: "leaf.fill")
                .font(.system(size: 260, weight: .light))
                .foregroundStyle(.white)
                .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 5)
        }
        .frame(width: 500, height: 500)
    }
}

#Preview("App Icon Canvas") {
    IconPreview()
}