import SwiftUI

public struct SwitchView: View {
    let coordinator: Coordinator

    public init(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    @ViewBuilder
    public var body: some View {
        switch coordinator.rootSwitcher.switchRoute {
        case .none:
            EmptyView()
        case .some(let route):
            route.contentView
        }
    }
}
