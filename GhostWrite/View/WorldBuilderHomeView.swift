//
//  WorldBuilderHomeView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/8/25.
//

import SwiftUI

struct WorldBuilderHomeView: View {
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack {
                Text("Start Builidng Your World")
                    .font(.largeTitle)
                    .padding(.top, 40)
                    .underline()
                Spacer()
                CardView(title: "Setting", systemImage: "globe.americas.fill")
                CardView(title: "Characters", systemImage: "person.3.fill")
                CardView(title: "Magic", systemImage: "sparkles")
                Spacer()
            }
        }
        
    }
}


#Preview {
    WorldBuilderHomeView()
}
