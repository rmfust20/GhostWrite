//
//  DismissViewButton.swift
//  GhostWrite
//
//  Created by Robert Fusting on 8/1/25.
//

import SwiftUI

struct DismissViewButton: View {
    @Binding var isPresented: Bool
    var body: some View {
        HStack {
            Button {
                isPresented.toggle()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title)
            }
            .buttonStyle(.plain)
            .padding()
            Spacer()
            
        }
    }
}

#Preview {
    DismissViewButton(isPresented: .constant(true))
}
