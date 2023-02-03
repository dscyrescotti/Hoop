import Routing
import SwiftUI
import GameBoard
import GameScore
import GameLanding

extension Route: Factory {
    @ViewBuilder
    public func contentView() -> some View {
        switch self {
        case .gameBoard:
            GameBoardView(dependency: environment.gameBoardDependency)
        case .gameScore:
            GameScoreView(dependency: environment.gameScoreDependency)
        case .gameLanding:
            GameLandingView(dependency: environment.gameLandingDependency)
        }
    }

    private var environment: Environment { .live }
}
