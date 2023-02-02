import SwiftUI

public protocol Factory {
    associatedtype Content: View
    @ViewBuilder
    func contentView() -> Content
}

extension Factory {
    func view() -> AnyView {
        AnyView(contentView())
    }
}
