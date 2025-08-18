//
//  CharacterCreationView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/29/25.
//

import SwiftUI

struct CharacterEditorView: View {
    @Binding var isPresented: Bool
    @State var selectedCard: CardItem?
    @ObservedObject var characterViewModel: EntityListViewModel
    
    private let cardItems: [CardItem] = [CardItem(title: "Backstory", systemImage: "book.closed.fill"),
                                        CardItem(title: "Personality", systemImage: "person.fill"),
                                        CardItem(title: "Motivation", systemImage: "heart.fill")]
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()

            VStack {
                DismissViewButton(isPresented: $isPresented)
                ForEach(cardItems) {item in
                    Button {
                        selectedCard = item
                    } label: {
                        CardView(title: item.title, systemImage: item.systemImage)
                    }
                    .buttonStyle(.plain)
                }
    
            }
            // In MainContent (PreviewTestView.swift)
            .fullScreenCover(item: $selectedCard) { card in
                AddInfoView(
                    attribute: card.title.lowercased(),
                    onDismiss: { selectedCard = nil },
                    addInfoViewModel: characterViewModel
                )
            }

        }
        .onAppear {
            print("helo")
            print(characterViewModel.entityType)
        }
    }
}

#Preview {
    CharacterEditorView(isPresented: .constant(true), characterViewModel: EntityListViewModel())
}
