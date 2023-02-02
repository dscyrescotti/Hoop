import SwiftUI

@propertyWrapper
public struct Coordinator: DynamicProperty {
    @Environment(\.dismiss) var dismissRoute
    @State var route: Route?

    public var wrappedValue: Route? {
        route
    }

    public var projectedValue: Coordinator { self }

    public init(route: Route? = nil) {
        self.route = route
    }

    public func present(_ route: Route) {
        self.route = route
    }

    public func dismiss() {
        dismissRoute()
    }
}
