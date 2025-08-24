//
//  ConfirmationView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 8/24/25.
//

import SwiftUI

struct ConfirmationView: View {
    @Binding var isPresented: Bool
    var onDismiss: () -> Void
    let text: String
    
    
    
    
    var body: some View {
        if isPresented {
            ZStack {
                // Blurred and dimmed background
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .blur(radius: 8)
                VStack{
                    Text(text)
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

#Preview {
    ConfirmationView(isPresented: .constant(true), onDismiss: ({}), text: "This is a test preview")
}
