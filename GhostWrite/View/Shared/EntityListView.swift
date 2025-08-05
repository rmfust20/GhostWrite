//
//  EntityListView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/28/25.
//

import SwiftUI
import CoreData

struct EntityListView: View {
    
    let entityName: String
    @State private var navigateLink: Bool = false
    @Binding var isPresented: Bool
    @StateObject var viewModel = EntityListViewModel()
    
    @ViewBuilder
    private var destinationView: some View {
        switch entityName {
        case "Location":
            LocationEditorView(isPresented: $navigateLink)
        case "Character":
            CharacterEditorView(isPresented: $navigateLink)
        case "Magic":
            MagicEditorView(isPresented: $navigateLink)
        default:
            Text("Unknown Entity")
        }
    }
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack {
                DismissViewButton(isPresented: $isPresented)
                TransitionButton(title: "Add \(entityName)", transitionBool: $navigateLink)
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.fetchedResults, id: \.objectID) {
                            entity in
                            Text(entity.value(forKey: "name") as? String ?? "Unknown")
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchEntities(entityName)
                }
                .fullScreenCover(isPresented: $navigateLink) {
                    destinationView
                }
            }
        }
    }
}

#Preview {
    EntityListView(entityName: "Magic", isPresented: .constant(true))
}
