import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.of(.button))
            .frame(maxWidth: .infinity)
            .padding(15)
            .background(Color.of(.rust))
            .cornerRadius(15)
            .foregroundColor(.of(.white))
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

public extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle {
        PrimaryButtonStyle()
    }
}
