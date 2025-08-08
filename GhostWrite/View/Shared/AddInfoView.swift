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
    var body: some View {
        Button {
            //Check if this is the first entry
            if addInfoViewModel.workingEntity == nil {
                //Save the new entity using the save function
                addInfoViewModel.constructModel(from: text)
            }
            else {
                //Simply update the exisitng entity
                
            }
        } label: {
            Text("Save")
                .font(.title3)
        }
        .padding()
    }
}

struct AddInfoView: View {
    
    let workingTitle : String
    @State private var text : String = ""
    @State private var previewText: String? = "Start Writing..."
    var onDismiss: () -> Void = {}
    @ObservedObject var addInfoViewModel : EntityListViewModel
    
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
                    SaveButtonView(addInfoViewModel: addInfoViewModel, text: $text)
                }
                Text(workingTitle)
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
                        .padding()
                }
                AskCasperView()

            }
        }
    }
}

#Preview {
    AddInfoView(workingTitle: "Culture", addInfoViewModel: EntityListViewModel())
}
