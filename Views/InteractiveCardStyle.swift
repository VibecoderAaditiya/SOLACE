//
//  InteractiveCardStyle.swift
//  SOLACE
//
//  Created by Aaditiya Pratap Singh on 30/08/26.
//


import SwiftUI

struct InteractiveCardStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.35, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == InteractiveCardStyle {
    static var interactiveCard: InteractiveCardStyle {
        InteractiveCardStyle()
    }
}