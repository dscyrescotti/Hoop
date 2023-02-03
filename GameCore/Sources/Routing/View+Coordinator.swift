import SwiftUI

public extension View {
    @ViewBuilder
    func coordinated(_ coordinator: Coordinator) -> some View {
        fullScreenCover(item: coordinator.$fullScreenRoute) { route in
            route.contentView
        }
    }
}
