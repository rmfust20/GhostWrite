//
//  AskSpectre.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/30/25.
//

import SwiftUI

struct AskSpectre: View {
    @State private var message: String = "Hello! How can I help you today?"
    @State private var displayedText: String = ""
    @State private var charIndex = 0

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("Casper")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 600, height: 600)
            // Speech bubble
            VStack(alignment: .leading) {
                Text(displayedText)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                            .shadow(radius: 4)
                    )
                    .overlay(
                        // Optional: add a "tail" to the bubble
                        Triangle()
                            .fill(Color.white)
                            .frame(width: 30, height: 20)
                            .offset(x: 30, y: 10),
                        alignment: .bottomLeading
                    )
            }
            .padding(.leading, 40)
            .padding(.bottom, 80)
        }
        .onAppear {
            displayedText = ""
            charIndex = 0
            Timer.scheduledTimer(withTimeInterval: 0.04, repeats: true) { timer in
                if charIndex < message.count {
                    let index = message.index(message.startIndex, offsetBy: charIndex)
                    displayedText.append(message[index])
                    charIndex += 1
                } else {
                    timer.invalidate()
                }
            }
        }
    }
}

// Simple triangle shape for the speech bubble tail
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    AskSpectre()
}
