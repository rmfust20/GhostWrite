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
    @ObservedObject var magicViewModel: EntityListViewModel
    
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
                    attribute: card.title,
                    onDismiss: { selectedCard = nil },
                    addInfoViewModel: magicViewModel
                )
            }
        }
        .onAppear {
            magicViewModel.setEntityType("Magic")
        }
    }
}

#Preview {
    MagicEditorView(isPresented: .constant(true),
    magicViewModel: EntityListViewModel())
}
