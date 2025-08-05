//
//  MagicHomeView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/28/25.
//

import SwiftUI

struct MagicHomeView: View {
    @Binding var isPresented: Bool
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack {
                DismissViewButton(isPresented: $isPresented)
                CardView(title: "Add Magic System")
                //display list of magic systems
            }

        }
    }
}

#Preview {
    MagicHomeView(isPresented: .constant(true))
}
