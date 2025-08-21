//
//  EntityListView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/28/25.
//

import SwiftUI
import CoreData
import Combine

struct EntityListView: View {
    
    let entityType: String
    @State private var navigateLink: Bool = false
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: EntityListViewModel
    
    
    
    @ViewBuilder
    private var destinationView: some View {
        switch entityType {
        case "Location":
            LocationEditorView(isPresented: $navigateLink, locationViewModel: viewModel)
        case "Character":
            CharacterEditorView(isPresented: $navigateLink, characterViewModel: viewModel)
        case "Magic":
            MagicEditorView(isPresented: $navigateLink, magicViewModel: viewModel)
        case "Chapter":
            AddInfoView(attribute: "content", onDismiss: {
                viewModel.fetchEntities(entityType)
                navigateLink = false
            }, addInfoViewModel: viewModel)
        default:
            Text("Unknown Entity")
        }
    }
    
    private func handleAddTap() {
        viewModel.setWorkingEntity(nil)
        viewModel.setEntityType(entityType)
        navigateLink = true
        }
    

    private func handleEntityTap(_ entity: NSManagedObject) {
        viewModel.setWorkingEntity(entity)
        viewModel.setEntityType(entityType)
        navigateLink = true
    }

    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack {
                DismissViewButton(isPresented: $isPresented)
                CardView(title: "Add \(entityType)")
                    .onTapGesture {
                        handleAddTap()
                    }
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.fetchedResults, id: \.objectID) {
                            entity in
                            CardView(
                                title:(entity.value(forKey: "name") as? String ?? "Unknown"),
                                systemImage: nil
                            )
                            .onTapGesture {
                                handleEntityTap(entity)
                            }
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchEntities(entityType)
                }
                .fullScreenCover(isPresented: $navigateLink) {
                    destinationView
                }
            }
        }
    }
    
}


#Preview {
    EntityListView(entityType: "Chapter", isPresented: .constant(true), viewModel: EntityListViewModel())
}
