import SwiftUI

public struct SpringButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.bold())
            .frame(maxWidth: .infinity)
            .padding(15)
            .background(Color.of(.rust))
            .cornerRadius(15)
            .foregroundColor(.white)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

public extension ButtonStyle where Self == SpringButtonStyle {
    static var springButtonStyle: SpringButtonStyle {
        SpringButtonStyle()
    }
}
