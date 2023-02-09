import SwiftUI

public struct DefaultButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

public extension ButtonStyle where Self == DefaultButtonStyle {
    static var `default`: DefaultButtonStyle {
        DefaultButtonStyle()
    }
}

