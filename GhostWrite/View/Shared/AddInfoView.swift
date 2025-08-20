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
                    HStack {
                        Button("Cancel") {
                            isPresented = false
                        }
                        Spacer()
                        Button("Save") {
                            // Handle save action here
                            Task {
                                await addInfoViewModel.saveEntity(text: text, attribute: attribute, name: entityName)
                            }
                            isPresented = false
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

struct AddInfoView: View {
    
    let attribute : String
    @State private var text : String = ""
    @State private var previewText: String? = "Start Writing..."
    var onDismiss: () -> Void = {}
    @ObservedObject var addInfoViewModel : EntityListViewModel
    @State private var showNamePrompt = false
    @State private var flexHeight: CGFloat = .infinity
    @State private var isExpanded: Bool = true
    
    private var titleText: String {
        let name = addInfoViewModel.workingEntity?.value(forKey: "name") as? String
        if attribute == "Chapter" {
            return (name ?? "Chapter")
        } else {
            return (name ?? "") + " " + attribute
        }
    }
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        onDismiss()
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
                            .padding(.horizontal,20)
                            .padding(.vertical, 23)
                    }
                        TextEditor(text: $text)
                            .scrollContentBackground(.hidden)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 1)
                            )
                            .frame(maxHeight: flexHeight)
                            .padding()
                            .overlay(
                                ExpandView(isExpanded: $isExpanded, flexHeight: $flexHeight, baseHeight: 200)
                                    .padding(24),
                            alignment: .bottomLeading
                                )
                            
                }
                Spacer()
                AskCasperView()

            }
            PromptUserToNameEntity(addInfoViewModel: addInfoViewModel,isPresented: $showNamePrompt, text: $text, attribute: attribute)
            
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
