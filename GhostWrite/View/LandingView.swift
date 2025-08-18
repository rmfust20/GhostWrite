//
//  LandingView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 8/1/25.
//

import SwiftUI

struct LandingView: View {
    
    @State private var navigateWrite = false
    @State private var navigateBuild = false
    @StateObject var viewModel = EntityListViewModel()
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("GhostWrite")
                        .font(.largeTitle)
                        .bold()
                    Image("Casper")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
                Spacer()
                TransitionButton(title: "Write", systemImage: "pencil.circle.fill", transitionBool: $navigateWrite)
               TransitionButton(title: "World Build", systemImage: "globe.americas.fill", transitionBool: $navigateBuild)
                .padding(.bottom, 100)
                Spacer()
            }
            .fullScreenCover(isPresented: $navigateWrite) {
                EntityListView(entityName: "Chapter", isPresented: $navigateWrite, viewModel: viewModel)
            }
            .fullScreenCover(isPresented: $navigateBuild) {
                WorldBuilderHomeView(isPresented: $navigateBuild, viewModel: viewModel)
                
            }
        }
    }
}

#Preview {
    LandingView()
}
