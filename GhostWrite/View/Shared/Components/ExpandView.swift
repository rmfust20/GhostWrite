//
//  ExpandView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 8/19/25.
//

import SwiftUI

struct ExpandView: View {
    @Binding var isExpanded: Bool
    @Binding var flexHeight: CGFloat
    let baseHeight: CGFloat
    var body: some View {
        HStack {
            Button {
                    withAnimation(.easeInOut) {
                        isExpanded.toggle()
                        flexHeight = isExpanded ? .infinity : baseHeight
                        }
                    } label: {
                        Image(isExpanded ? "reduce" : "expand")
                            }
            Spacer()
            
        }
    }
}

