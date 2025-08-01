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
                Text("Start Builidng Your World")
                    .font(.largeTitle)
                    .padding(.top, 40)
                    .underline()
                Spacer()
                TransitionButton(title: "Locations", systemImage: "map.fill", transitionBool: $navigateSetting)
                CardView(title: "Characters", systemImage: "person.3.fill")
                CardView(title: "Magic", systemImage: "sparkles")
                Spacer()
                Button {
                    isPresented.toggle()
                } label: {
                    Text("Done")
                        
                }
            }
            .fullScreenCover(isPresented: $navigateSetting) {
                SettingView(isPresented: $navigateSetting)
            }
        }
        
    }
}


#Preview {
    WorldBuilderHomeView(isPresented: .constant(true))
}
