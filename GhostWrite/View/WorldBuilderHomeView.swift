//
//  WorldBuilderHomeView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/8/25.
//

import SwiftUI

struct WorldBuilderHomeView: View {
    
    @Binding var isPresented: Bool
    @State private var navigateSetting : Bool = false
    @State private var navigateCharacters : Bool = false
    @State private var navigateMagic : Bool = false
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack {
                DismissViewButton(isPresented: $isPresented)
                Text("Start Builidng Your World")
                    .font(.largeTitle)
                Spacer()
                TransitionButton(title: "Locations", systemImage: "map.fill", transitionBool: $navigateSetting)
                TransitionButton(title: "Characters", systemImage: "person.3.fill", transitionBool: $navigateCharacters)
                TransitionButton(title: "Magic", systemImage: "sparkles", transitionBool: $navigateMagic)
                Spacer()
            }
            .fullScreenCover(isPresented: $navigateSetting) {
                EntityListView(entityName: "Location", isPresented: $navigateSetting)
            }
            .fullScreenCover(isPresented: $navigateCharacters) {
                EntityListView(entityName: "Character", isPresented: $navigateCharacters)
            }
            .fullScreenCover(isPresented: $navigateMagic) {
                EntityListView(entityName: "Magic", isPresented: $navigateMagic)
            }
        }
        
    }
}


#Preview {
    WorldBuilderHomeView(isPresented: .constant(true))
}
