import Routing
import SwiftUI
import GameBoard
import GameLanding

extension Route: Factory {
    @ViewBuilder
    public func contentView() -> some View {
        switch self {
        case .gameBoard:
            GameBoardView(dependency: environment.gameBoardDependency)
        case .gameLanding:
            GameLandingView(dependency: environment.gameLandingDependency)
        }
    }

    private var environment: Environment { .live }
}
