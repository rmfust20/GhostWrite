//
//  PreviewTestView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/11/25.
//

import SwiftUI


struct MainContent: View {
    
    @Binding var selectedCard: CardItem?
    @ObservedObject var locationViewModel: EntityListViewModel
    
    private let cardItems: [CardItem] = [
        CardItem(title: "Architecture", systemImage: "door.garage.closed"),
        CardItem(title: "History", systemImage: "book.closed"),
        CardItem(title: "Important People", systemImage: "figure.stand"),
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
                                    CustomCardView(title: item.title, systemImage: item.systemImage)

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
                        workingTitle: card.title,
                        onDismiss: { selectedCard = nil },
                        addInfoViewModel: locationViewModel
                    )
                }
            }
        }
    }

struct CustomCardView : View {
    let title: String
    let systemImage: String

    init(title: String = "Add Card", systemImage: String = "plus.circle.fill") {
        self.title = title
        self.systemImage = systemImage
    }

    var body: some View {
        VStack {
            Image(systemName: systemImage)
                .font(.system(size: 45))
            Text(title)
                .font(.title2)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(maxWidth: .infinity, minHeight: 40) // Ensures consistent text height
        }
        .frame(maxWidth: .infinity, minHeight: 140)
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .opacity(0.4)
        )
        .padding()
    }
}


struct LocationEditorView: View {
    
    @State private var text: String = "hello"
    @State private var selectedCard: CardItem?
    @Binding var isPresented: Bool
    @ObservedObject var locationViewModel: EntityListViewModel
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack {
                DismissViewButton(isPresented: $isPresented)
    
                MainContent(selectedCard: $selectedCard, locationViewModel: locationViewModel)
                    
                
            }
        }
    }
}

#Preview {
    LocationEditorView(isPresented: .constant(false),
    locationViewModel: EntityListViewModel())
        
}

