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
    @State private var flexHeight: CGFloat = 275
    @State private var isExpanded: Bool = false
    @StateObject var viewModel: CasperViewModel = CasperViewModel()
    @State private var responseText: String? = nil
    @State private var typingTask: Task<Void, Never>? = nil
    @State private var isThinking: Bool = false
    
    

    var body: some View {
        VStack {
            HStack {
                Text("Ask Casper")
                Image("Casper")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 64, height: 64)
            }
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(responseText ?? "")
                            InProgressView(text:"Thinking", isPresented: $isThinking)
                        }
                        Color.clear.frame(height:1).id("bottom")
                    }
                }
                
                .padding(.horizontal)
                .onChange(of: responseText) { _, _ in
                    withAnimation {
                        proxy.scrollTo("bottom", anchor: .bottom)
                    }
                }
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
                                Task {
                                    responseText = ""
                                    isThinking = true
                                        if let response = await viewModel.generateResponse(text) {
                                            text = ""
                                            isThinking = false
                                            typingTask?.cancel()
                                            typingTask = Task {
                                                            for (char) in response{
                                                                try? await Task.sleep(nanoseconds: 30_000_000) // 30ms per char
                                                                responseText!.append(char)
                                                            }
                                                        }
                                                    }
                                                }
                        } label: {
                            Image(systemName: "arrowshape.up.circle.fill")
                        }
                    }
                .padding()
            }
            .padding()
            ExpandView(isExpanded: $isExpanded, flexHeight: $flexHeight, baseHeight: 275)
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 1)
        )
        .padding()
        .frame(maxWidth: .infinity, maxHeight: flexHeight)
    }
}

#Preview {
    AskCasperView()
}
