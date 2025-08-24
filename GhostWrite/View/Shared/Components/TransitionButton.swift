//
//  TransitionButton.swift
//  GhostWrite
//
//  Created by Robert Fusting on 8/1/25.
//

import SwiftUI

struct TransitionButton: View {
    let title: String
    let systemImage: String?
    @Binding var transitionBool : Bool
    
    init(title: String = "Add Card", systemImage: String? = "plus.circle.fill", transitionBool: Binding<Bool>) {
        self.title = title
        self.systemImage = systemImage
        self._transitionBool = transitionBool
        
    }
    
    var body: some View {
        Button {
            transitionBool.toggle() // Placeholder for transition logic
        }label: {
            CardView(title: title, systemImage: systemImage)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    TransitionButton(title: "Add Magic System", systemImage: "wand.and.stars", transitionBool: .constant(false)) // Example usage
}
