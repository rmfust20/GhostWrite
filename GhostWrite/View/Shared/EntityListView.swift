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
    @ObservedObject var viewModel: EntityListViewModel
    
    var body: some View {
        CardView(title: entityName)
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
    }
}

#Preview {
    let mockViewModel = EntityListViewModel()
    EntityListView(entityName: "Entity", viewModel: mockViewModel)
}
