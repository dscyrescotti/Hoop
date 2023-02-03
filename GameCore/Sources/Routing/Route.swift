import SwiftUI
import Foundation

public enum Route: Equatable, Identifiable, Hashable {
    case gameBoard
    case gameScore
    case gameLanding

    public var id: Int {
        hashValue
    }
}

extension Route {
    private var factory: any Factory {
        self as! any Factory
    }

    var contentView: AnyView {
        factory.view()
    }
}
