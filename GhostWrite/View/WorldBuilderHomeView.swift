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
    @ObservedObject var viewModel: EntityListViewModel
    
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
                EntityListView(entityType: "Location", isPresented: $navigateSetting, viewModel: viewModel)
            }
            .fullScreenCover(isPresented: $navigateCharacters) {
                EntityListView(entityType: "Character", isPresented: $navigateCharacters, viewModel: viewModel)
            }
            .fullScreenCover(isPresented: $navigateMagic) {
                EntityListView(entityType: "Magic", isPresented: $navigateMagic, viewModel: viewModel)
            }
        }
        
    }
}


#Preview {
    WorldBuilderHomeView(isPresented: .constant(true), viewModel: EntityListViewModel())
}
