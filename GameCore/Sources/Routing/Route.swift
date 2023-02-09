import Model
import SwiftUI
import Foundation

public enum Route: Equatable, Identifiable, Hashable {
    case gameScore
    case ballPicker
    case gameLanding
    case gameBoard(mode: GameMode)

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
