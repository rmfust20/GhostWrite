//
//  AddInfoView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/15/25.
//

import SwiftUI

struct AddInfoView: View {
    
    let workingTitle : String
    @State private var text : String = ""
    @State private var previewText: String? = "Start Writing..."
    var onDismiss: () -> Void = {}
    
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
    AddInfoView(workingTitle: "Culture")
}
