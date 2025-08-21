//
//  AddInfoView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/15/25.
//

import SwiftUI

struct SaveButtonView: View {
    @ObservedObject var addInfoViewModel: EntityListViewModel
    @Binding var text: String
    @Binding var isPresented: Bool
    let attribute: String
    var body: some View {
        Button {
            //Check if this is the first entry
            if addInfoViewModel.workingEntity == nil {
                //Save the new entity using the save function
                //PromptUserToNameEntity
                isPresented = true
            }
            else {
                //Simply update the exisitng entity
                Task {
                    await addInfoViewModel.updateEntity(text: text, attribute: attribute)
                }
                
            }
        } label: {
            Text("Save")
                .font(.title3)
        }
        .padding()
    }
}

import SwiftUI

struct PromptUserToNameEntity: View {
    @ObservedObject var addInfoViewModel: EntityListViewModel
    @State private var entityName: String = ""
    @Binding var isPresented: Bool
    @Binding var text: String
    @State private var saveResultString: String = ""
    let attribute : String

    var body: some View {
        if isPresented {
            ZStack {
                // Blurred and dimmed background
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .blur(radius: 8)

                // Popup content
                VStack(spacing: 16) {
                    Text("Enter Entity Name")
                        .font(.headline)
                    TextField("Name", text: $entityName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    Text(saveResultString)
                        .foregroundStyle(Color.red)
                    HStack {
                        Button("Cancel") {
                            isPresented = false
                        }
                        Spacer()
                        Button("Save") {
                            // Handle save action here
                            Task {
                                saveResultString =  await addInfoViewModel.saveEntity(text: text, attribute: attribute, name: entityName)
                                if saveResultString == "success" {
                                    isPresented = false
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                .shadow(radius: 10)
                .frame(maxWidth: 300)
            }
            .transition(.opacity)
            .animation(.easeInOut, value: isPresented)
        }
    }
}

struct UnsavedChangesView: View {
    @Binding var isPresented: Bool
    @Binding var onDismiss: () -> Void
    var body: some View {
        if isPresented {
            ZStack {
                // Blurred and dimmed background
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .blur(radius: 8)
                VStack{
                    Text("Are you sure you want to quit? You have unsaved changes")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                    HStack {
                        Button {
                            isPresented = false
                            onDismiss()
                        } label: {
                            Text("Yes")
                        }
                        Spacer()
                        Button {
                            isPresented = false
                            
                        } label: {
                            Text("No")
                        }
                    }
                    .padding()
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                .shadow(radius: 10)
                .frame(maxWidth: 300)
            }
            .transition(.opacity)
            .animation(.easeInOut, value: isPresented)
        }
    }
}

struct AddInfoView: View {
    
    let attribute : String
    @State private var text : String = ""
    @State private var previewText: String? = "Start Writing..."
    @State var onDismiss: () -> Void = {}
    @ObservedObject var addInfoViewModel : EntityListViewModel
    @State private var showNamePrompt = false
    @State private var flexHeight: CGFloat = .infinity
    @State private var isExpanded: Bool = true
    @State private var showUnsavedChangesPrompt = false
    
    private var titleText: String {
        let name = addInfoViewModel.workingEntity?.value(forKey: "name") as? String
        if addInfoViewModel.entityType == "Chapter" {
            return (name ?? "New Chapter")
        } else {
            return (name ?? "New") + " " + attribute
        }
    }
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        //Check if there are unsaved changes
                        //basically we have a working entity and the text has changed
                        //or its a new entity in which case if text is empty it has changed
                        print("pressed")
                        if (addInfoViewModel.workingEntity != nil && (addInfoViewModel.workingEntity?.value(forKey: attribute) as? String ?? "") != text) {
                            print("Tom!")
                            showUnsavedChangesPrompt = true
                        } else if (text != "" && addInfoViewModel.workingEntity == nil) {
                            print("wait what?")
                            showUnsavedChangesPrompt = true
                        } else {
                            onDismiss()
                        }
                        
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .padding()
                        
                        
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    SaveButtonView(addInfoViewModel: addInfoViewModel, text: $text, isPresented: $showNamePrompt ,attribute: attribute)
                        
                }
                Text(
                    titleText
                )
                .font(.title)
                    .font(.title)
                
                ZStack(alignment: .topLeading) {
                    if text.isEmpty {
                        Text(previewText ?? "")
                            .foregroundColor(.gray)
                            .padding(.horizontal,35)
                            .padding(.vertical, 38)
                    }
                        TextEditor(text: $text)
                            .scrollContentBackground(.hidden)
                            .padding(15)
                            .padding(.bottom,30)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 1)
                            )
                            .frame(maxHeight: flexHeight)
                            .padding()
                }
                .overlay(
                    ExpandView(isExpanded: $isExpanded, flexHeight: $flexHeight, baseHeight: 200)
                        .padding(24),
                alignment: .bottomLeading
                    )
                Spacer()
                AskCasperView()

            }
            PromptUserToNameEntity(addInfoViewModel: addInfoViewModel,isPresented: $showNamePrompt, text: $text, attribute: attribute)
            UnsavedChangesView(isPresented: $showUnsavedChangesPrompt, onDismiss: $onDismiss)
        }
        .onAppear {
            text = attribute == "Chapter" ? (addInfoViewModel.workingEntity?.value(forKey: "content") as? String ?? "") : (addInfoViewModel.workingEntity?.value(forKey: attribute) as? String ?? "")
            print(addInfoViewModel.workingEntity?.value(forKey: attribute) as? String ?? "No Name")
        }
    }
}

#Preview {
    AddInfoView(attribute: "Culture", addInfoViewModel: EntityListViewModel())
}
