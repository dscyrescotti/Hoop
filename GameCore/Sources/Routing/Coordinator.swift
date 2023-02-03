import SwiftUI

@propertyWrapper
public struct Coordinator: DynamicProperty {
    @Environment(\.dismiss) var dismissRoute
    @StateObject var rootSwitcher: RootSwitcher = .shared
    @State var fullScreenRoute: Route?

    public var wrappedValue: Route? { nil }

    public var projectedValue: Coordinator { self }

    public init() { }

    public func fullScreen(_ route: Route) {
        self.fullScreenRoute = route
    }

    public func dismiss() {
        dismissRoute()
    }

    public func switchScreen(_ route: Route, animated: Bool = true) {
        if animated {
            withAnimation {
                rootSwitcher.switchRoute = route
            }
        } else {
            rootSwitcher.switchRoute = route
        }
    }
}

class RootSwitcher: ObservableObject {
    @Published var switchRoute: Route?

    private init() { }

    static let shared = RootSwitcher()
}
