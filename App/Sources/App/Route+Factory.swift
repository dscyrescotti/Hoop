import Routing
import SwiftUI
import GameBoard
import GameScore
import BallPicker
import GameLanding

extension Route: Factory {
    @ViewBuilder
    public func contentView() -> some View {
        switch self {
        case let .gameBoard(gameMode):
            let dependency = environment.gameBoardDependency(gameMode)
            GameBoardView(dependency: dependency)
        case .gameScore:
            GameScoreView(dependency: environment.gameScoreDependency)
        case .gameLanding:
            GameLandingView(dependency: environment.gameLandingDependency)
        case .ballPicker:
            BallPickerView(dependency: environment.ballPickerDependency)
        }
    }

    private var environment: Environment { .live }
}
