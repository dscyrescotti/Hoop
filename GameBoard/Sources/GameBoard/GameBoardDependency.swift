import Core
import Model

public struct GameBoardDependency {
    let gameMode: GameMode
    let gameManager: GameManager

    public init(
        gameMode: GameMode,
        gameManager: GameManager
    ) {
        self.gameMode = gameMode
        self.gameManager = gameManager
    }

    var viewModel: GameBoardViewModel {
        GameBoardViewModel(dependency: self)
    }
}
