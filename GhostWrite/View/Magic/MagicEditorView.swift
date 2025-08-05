//
//  MagicSystemView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/29/25.
//

import SwiftUI

struct MagicEditorView: View {
    @Binding var isPresented: Bool
    @State var selectedCard: CardItem?
    
    private let cardItems: [CardItem] = [
        CardItem(title: "Abilities", systemImage: "wind.circle"),
        CardItem(title: "Limitations", systemImage: "moon.stars.fill")
    ]
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack {
                DismissViewButton(isPresented: $isPresented)
                ForEach(cardItems) { item in
                    Button {
                        selectedCard = item
                    } label: {
                        CardView(title: item.title, systemImage: item.systemImage)
                        
                    }
                    .buttonStyle(.plain)
                }
                
            }
            .fullScreenCover(item: $selectedCard) { card in
                AddInfoView(
                    workingTitle: card.title,
                    onDismiss: { selectedCard = nil }
                )
            }
        }
    }
}

#Preview {
    MagicEditorView(isPresented: .constant(true))
}
