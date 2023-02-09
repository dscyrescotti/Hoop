import SwiftUI

public struct NavBar: View {
    let title: String
    let dismissAction: () -> Void

    public init(title: String, dismissAction: @escaping () -> Void) {
        self.title = title
        self.dismissAction = dismissAction
    }

    public var body: some View {
        HStack {
            Color.clear
                .frame(width: 25, height: 25)
            Spacer()
            Text(title)
                .font(.of(.headline2))
            Spacer()
            Button(action: dismissAction) {
                Image.loadImage(.xmark)
            }
            .font(.of(.button2))
            .frame(width: 25, height: 25)
            .buttonStyle(.default)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 24)
        .padding(.vertical, 10)
        .foregroundColor(.of(.rust))
    }
}
