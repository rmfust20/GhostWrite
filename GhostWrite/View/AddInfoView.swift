//
//  AddInfoView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/15/25.
//

import SwiftUI

struct AddInfoView: View {
    
    let workingCard : CardView?
    @State private var text : String = ""
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack {
                workingCard
                TextEditor(text: $text)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding()
                    .padding(.vertical, 20)
                workingCard
                    
            }
            
            Button {
               print("hello")
            } label: {
                Image(systemName: "xmark")

            }
        }
    }
}

#Preview {
    AddInfoView(workingCard: CardView(title: "Culture", systemImage: "paintbrush.fill"))
}
