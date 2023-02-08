import SwiftUI

public struct NewBadge: View {

    let color: Colors

    public init(_ color: Colors = .fireEngineRed) {
        self.color = color
    }

    public var body: some View {
        Text("New")
            .font(.of(.caption))
            .foregroundColor(.of(.white))
            .padding(.vertical, 3)
            .padding(.horizontal, 5)
            .background(Capsule())
            .foregroundColor(.of(color))
    }
}
