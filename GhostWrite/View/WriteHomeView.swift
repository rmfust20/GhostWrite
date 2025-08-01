//
//  WriteHomeView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 8/1/25.
//

import SwiftUI

struct WriteHomeView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Button {
            isPresented.toggle()
        } label: {
            Text("hello")
        }
    }
}

#Preview {
    WriteHomeView(isPresented: .constant(true))
}
