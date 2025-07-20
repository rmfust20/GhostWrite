import SwiftUI

struct CardView: View {
    let title: String
    let systemImage: String

    init(title: String = "Add Card", systemImage: String = "plus.circle.fill") {
        self.title = title
        self.systemImage = systemImage
    }

    var body: some View {
        VStack {
            Image(systemName: systemImage)
                .font(.system(size: 45))
            Text(title)
                .font(.title2)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(maxWidth: .infinity, minHeight: 40) // Ensures consistent text height
        }
        .frame(maxWidth: .infinity, minHeight: 140)
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .opacity(0.4)
        )
        .padding()
    }
}

#Preview {
    CardView()
}
