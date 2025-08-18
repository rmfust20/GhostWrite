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
    
    let entityName: String
    @State private var navigateLink: Bool = false
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: EntityListViewModel
    
    
    
    @ViewBuilder
    private var destinationView: some View {
        switch entityName {
        case "Location":
            LocationEditorView(isPresented: $navigateLink, locationViewModel: viewModel)
        case "Character":
            CharacterEditorView(isPresented: $navigateLink, characterViewModel: viewModel)
        case "Magic":
            MagicEditorView(isPresented: $navigateLink, magicViewModel: viewModel)
        case "Chapter":
            AddInfoView(attribute: "Chapter", onDismiss: {
                navigateLink = false
            }, addInfoViewModel: viewModel)
        default:
            Text("Unknown Entity")
        }
    }
    
    private func handleAddTap() {
        viewModel.setWorkingEntity(nil)
        viewModel.setEntityType(entityName)
        navigateLink = true
        }
    

    private func handleEntityTap(_ entity: NSManagedObject) {
        viewModel.setWorkingEntity(entity)
        viewModel.setEntityType(entityName)
        navigateLink = true
    }

    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack {
                DismissViewButton(isPresented: $isPresented)
                CardView(title: "Add \(entityName)")
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
    EntityListView(entityName: "Chapter", isPresented: .constant(true), viewModel: EntityListViewModel())
}
