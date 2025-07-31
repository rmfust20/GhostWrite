//
//  AskCasperView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/20/25.
//

import SwiftUI

struct AskCasperView: View {
    
    @State private var text: String = ""
    @State private var previewText: String? = "Type your question here..."

    var body: some View {
        VStack {
            HStack {
                Text("Ask Casper")
                    .font(.system(size: 17, design: .serif))
                Image("Casper")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 64, height: 64)
            }
            
            ZStack(alignment: .bottomTrailing) {
                ZStack(alignment: .topLeading) {
                    if text.isEmpty {
                        Text(previewText ?? "")
                            .foregroundColor(.gray)
                            .padding(.horizontal,8)
                            .padding(.vertical, 16)
                    }
                    TextEditor(text: $text)
                        .font(.body)
                        .padding(8)
                        .padding(.trailing, 40)
                        .scrollContentBackground(.hidden)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(lineWidth: 1)
                        )
                }
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "arrowshape.up.circle.fill")
                    }
                }
                .padding()
            }
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 1)
        )
        .padding()
        .frame(width:.infinity, height: 200)
    }
}

#Preview {
    AskCasperView()
}
