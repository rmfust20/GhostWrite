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
            LocationEditorView(isPresented: $navigateLink, locationViewModel: viewModel)
        case "Character":
            CharacterEditorView(isPresented: $navigateLink, characterViewModel: viewModel)
        case "Magic":
            MagicEditorView(isPresented: $navigateLink, magicViewModel: viewModel)
        case "Chapter":
            AddInfoView(workingTitle: "Chapter", onDismiss: {
                navigateLink = false
            }, addInfoViewModel: viewModel)
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
                    .onTapGesture {
                        viewModel.setWorkingEntity(nil)
                        // based on the entityName, set the model to the apporiate type
                        viewModel.setWorkingModel(entityName)
                    }
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.fetchedResults, id: \.objectID) {
                            entity in
                            TransitionButton(
                                title:(entity.value(forKey: "name") as? String ?? "Unknown"),
                                systemImage: nil,
                                transitionBool: $navigateLink
                            )
                            .onTapGesture {
                                viewModel.setWorkingEntity(entity)
                                viewModel.setWorkingModel(entityName)
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
    EntityListView(entityName: "Chapter", isPresented: .constant(true))
}
