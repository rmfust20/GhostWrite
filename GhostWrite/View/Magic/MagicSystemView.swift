//
//  MagicSystemView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/29/25.
//

import SwiftUI

struct MagicSystemView: View {
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()

            VStack {
                CardView(title: "Abilities", systemImage: "wind.circle")
                CardView(title: "Limitations", systemImage: "moon.stars.fill")
            }

        }
    }
}

#Preview {
    MagicSystemView()
}
