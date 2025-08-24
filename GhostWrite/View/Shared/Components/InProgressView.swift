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
        @Binding var isPresented: Bool
        
        @State private var dotCount = 0
        
        init(
            text: String,
            interval: TimeInterval = 0.50,
            maxDots: Int = 3,
            showsSpinner: Bool = true,
            isPresented: Binding<Bool> = .constant(true)
            
        ) {
            self.baseText = text.trimmingCharacters(in: CharacterSet(charactersIn: ". ").inverted.inverted)
            self.interval = interval
            self.maxDots = maxDots
            self.showsSpinner = showsSpinner
            self._isPresented = isPresented
        }
        
    var body: some View {
        if isPresented {
            HStack(spacing: 10) {
                if showsSpinner {
                    ProgressView()
                        .controlSize(.regular)
                }
                
                Text("\(baseText)\(String(repeating: ".", count: dotCount))")
                    .font(.headline)
                    .monospaced()
                    .animation(.easeInOut(duration: 0.2), value: dotCount)
                    .accessibilityLabel("\(baseText) in progress")
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 14)
            .shadow(radius: 6, y: 2)
            .onReceive(Timer.publish(every: interval, on: .main, in: .common).autoconnect()) { _ in
                dotCount = (dotCount + 1) % (maxDots + 1)
            }
        }
    }
}

#Preview {
    InProgressView(text:"Saving")
}
