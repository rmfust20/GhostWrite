//
//  SettingView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/8/25.
//

import SwiftUI
import CoreData

struct AddLocationView: View {
    var body: some View {
        Text("Add Location View")
    }
}

struct SettingView: View {
    @Binding var isPresented: Bool
    @State private var showAddLocation = false
    @State private var newName = ""
    @State private var newLore = ""

        var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack {
                DismissViewButton(isPresented: $isPresented)
                Text("Locations")
                    .font(.largeTitle)
                Button {
                    showAddLocation = true
                    
                } label: {
                    CardView(title: "Add Location", systemImage: "plus.circle.fill")
                        
                }
                .buttonStyle(.plain)
                
                
                }
            }
        .fullScreenCover(isPresented: $showAddLocation) {
                LocationEditorView(isPresented: $showAddLocation)
            }
        }
    }

#Preview {
    SettingView(isPresented: .constant(true))
        .environment(\.managedObjectContext, PreviewCoreDataStack.shared.viewContext)
}
