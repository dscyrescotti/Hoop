import Core

public struct GameScoreDependency {
    let gameManager: GameManager

    public init(gameManager: GameManager) {
        self.gameManager = gameManager
    }

    var viewModel: GameScoreViewModel {
        GameScoreViewModel(dependency: self)
    }
}
