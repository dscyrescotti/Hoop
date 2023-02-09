import SwiftUI

public extension View {
    @ViewBuilder
    func coordinated(_ coordinator: Coordinator, onDismiss: (() -> Void)? = nil) -> some View {
        fullScreenCover(item: coordinator.$fullScreenRoute, onDismiss: onDismiss) { route in
            route.contentView
        }
    }
}
