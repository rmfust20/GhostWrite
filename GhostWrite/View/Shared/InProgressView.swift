//
//  InProgressView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 8/22/25.
//

import SwiftUI
import Combine

struct InProgressView: View {
        private let baseText: String
        private let interval: TimeInterval
        private let maxDots: Int
        private let showsSpinner: Bool
        
        @State private var dotCount = 0
        
        /// - Parameters:
        ///   - text: The base text (pass "Saving", not "Saving...")
        ///   - interval: Time between dot changes
        ///   - maxDots: Number of dots to cycle through (0...maxDots)
        ///   - showsSpinner: Whether to display a ProgressView
        init(
            text: String,
            interval: TimeInterval = 0.35,
            maxDots: Int = 3,
            showsSpinner: Bool = true
        ) {
            // Trim trailing dots/spaces so we control the ellipsis animation
            self.baseText = text.trimmingCharacters(in: CharacterSet(charactersIn: ". ").inverted.inverted)
            self.interval = interval
            self.maxDots = maxDots
            self.showsSpinner = showsSpinner
        }
        
        var body: some View {
            HStack(spacing: 10) {
                if showsSpinner {
                    ProgressView()
                        .controlSize(.regular)
                }
                
                Text("\(baseText)\(String(repeating: ".", count: dotCount))")
                    .font(.headline)
                    .monospaced() // reduces layout jitter as dots change
                    .animation(.easeInOut(duration: 0.2), value: dotCount)
                    .accessibilityLabel("\(baseText) in progress")
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 14)
            //.background(.ultraThinMaterial, in: Capsule())
            .shadow(radius: 6, y: 2)
            .onReceive(Timer.publish(every: interval, on: .main, in: .common).autoconnect()) { _ in
                dotCount = (dotCount + 1) % (maxDots + 1)
            }
        }
}

#Preview {
    InProgressView(text:"Saving")
}
