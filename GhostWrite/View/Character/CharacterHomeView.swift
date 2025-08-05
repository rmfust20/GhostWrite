//
//  CharacterHomeView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/29/25.
//

import SwiftUI

struct CharacterHomeView: View {
    @Binding var isPresented: Bool
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack {
                DismissViewButton(isPresented: $isPresented)
                CardView(title: "Add Character")
                //Display list of characters
            }

        }
    }
}

#Preview {
    CharacterHomeView(isPresented: .constant(true))
        
}
