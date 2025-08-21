//
//  TestPreviewView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 8/9/25.
//

import SwiftUI

struct TestPreviewView: View {
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

#Preview {
    TestPreviewView(isPresented: .constant(true), onDismiss: .constant({}))
}
