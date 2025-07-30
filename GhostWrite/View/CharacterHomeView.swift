//
//  CharacterHomeView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/29/25.
//

import SwiftUI

struct CharacterHomeView: View {
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack {
                CardView(title: "Add Character")
                //Display list of characters
            }

        }
    }
}

#Preview {
    CharacterHomeView()
}
