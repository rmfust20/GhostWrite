//
//  CharacterCreationView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/29/25.
//

import SwiftUI

struct CharacterCreationView: View {
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()

            VStack {
                CardView(title: "Backstory", systemImage: "book.closed.fill")
                CardView(title: "Personality", systemImage: "person.fill")
                CardView(title: "Motivations", systemImage: "heart.fill")
    
            }

        }
    }
}

#Preview {
    CharacterCreationView()
}
