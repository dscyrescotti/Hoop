import Core

public struct GameBoardDependency {
    let gameManager: GameManager

    public init(gameManager: GameManager) {
        self.gameManager = gameManager
    }

    var viewModel: GameBoardViewModel {
        GameBoardViewModel(dependency: self)
    }
}
