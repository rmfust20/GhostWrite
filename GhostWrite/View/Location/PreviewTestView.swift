//
//  PreviewTestView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/11/25.
//

import SwiftUI

struct CardItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let systemImage: String
}

struct MainContent: View {
    
    @Binding var selectedCard: CardItem?
    
    private let cardItems: [CardItem] = [
        CardItem(title: "Architecture", systemImage: "door.garage.closed"),
        CardItem(title: "History", systemImage: "book.closed"),
        CardItem(title: " Important People", systemImage: "figure.stand"),
        CardItem(title: "Culture", systemImage: "paintbrush.fill"),
        CardItem(title: "General", systemImage: "questionmark.circle.fill")
    ]
    
    // Helper to chunk array into groups of 2
        private var chunkedItems: [[CardItem]] {
            stride(from: 0, to: cardItems.count, by: 2).map {
                Array(cardItems[$0..<min($0 + 2, cardItems.count)])
            }
        }
        
        var body: some View {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(chunkedItems, id: \.self) { row in
                        HStack(spacing: 16) {
                            ForEach(row) { item in
                                
                                Button {
                                    selectedCard = item
                                    
                                } label : {
                                    CardView(title: item.title, systemImage: item.systemImage)
                                        .frame(height: 200)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .padding()
                // In MainContent (PreviewTestView.swift)
                .fullScreenCover(item: $selectedCard) { card in
                    AddInfoView(
                        workingCard: CardView(title: card.title, systemImage: card.systemImage),
                        onDismiss: { selectedCard = nil }
                    )
                }
            }
        }
    }


struct PreviewTestView: View {
    
    @State private var text: String = "hello"
    @Binding var showAddLocation: Bool
    @State private var selectedCard: CardItem?
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack {
                Button {
                    showAddLocation = false
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                        .font(.system(size: 35))
                        
                }
                
                MainContent(selectedCard: $selectedCard)
                    
                
            }
        }
    }
}

#Preview {
    PreviewTestView(showAddLocation: .constant(false))
        
}
