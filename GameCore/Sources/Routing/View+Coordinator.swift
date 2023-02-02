import SwiftUI

public extension View {
    @ViewBuilder
    func coordinated(_ coordinator: Coordinator) -> some View {
        fullScreenCover(item: coordinator.$route) { route in
            route.contentView
        }
    }
}
