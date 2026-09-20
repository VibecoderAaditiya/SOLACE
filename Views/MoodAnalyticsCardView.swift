//
//  MoodAnalyticsCardView.swift
//  SOLACE
//
//  Created by Aaditiya Pratap Singh on 29/08/26.
//


import SwiftUI

struct MoodAnalyticsCardView: View {
    // Mock analytics data for visual representation
    let weeklyMoods: [(day: String, height: CGFloat, isSelected: Bool)] = [
        ("Mon", 0.7, false),
        ("Tue", 0.5, false),
        ("Wed", 0.9, false),
        ("Thu", 0.6, false),
        ("Fri", 0.8, false),
        ("Sat", 0.95, true),
        ("Sun", 0.4, false)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Mood Analytics")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)
                        .tracking(1)
                    
                    Text("Mostly Peaceful")
                        .font(.headline)
                        .foregroundStyle(.primary)
                }
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "flame.fill")
                        .font(.caption)
                        .foregroundStyle(Color(red: 0.15, green: 0.30, blue: 0.25))
                    Text("5 Day Streak")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(red: 0.15, green: 0.30, blue: 0.25))
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Capsule().fill(Color(red: 0.15, green: 0.30, blue: 0.25).opacity(0.12)))
            }
            
            // Visual Bar Chart
            HStack(alignment: .bottom, spacing: 12) {
                ForEach(weeklyMoods, id: \.day) { item in
                    VStack(spacing: 8) {
                        ZStack(alignment: .bottom) {
                            Capsule()
                                .fill(Color.primary.opacity(0.06))
                                .frame(width: 14, height: 70)
                            
                            Capsule()
                                .fill(item.isSelected ? Color(red: 0.15, green: 0.30, blue: 0.25) : Color.primary.opacity(0.25))
                                .frame(width: 14, height: 70 * item.height)
                        }
                        
                        Text(item.day)
                            .font(.caption2)
                            .fontWeight(item.isSelected ? .bold : .regular)
                            .foregroundStyle(item.isSelected ? Color.primary : Color.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 8)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(uiColor: .secondarySystemGroupedBackground))
                .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 4)
        )
    }
}

#Preview {
    MoodAnalyticsCardView()
        .padding()
        .background(Color(uiColor: .systemGroupedBackground))
}