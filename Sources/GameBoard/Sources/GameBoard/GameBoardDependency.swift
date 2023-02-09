import Core
import Model
import Defaults

public struct GameBoardDependency {
    let gameMode: GameMode
    let gameManager: GameManager
    let userDefaults: UserDefaultService

    public init(
        gameMode: GameMode,
        gameManager: GameManager,
        userDefaults: UserDefaultService
    ) {
        self.gameMode = gameMode
        self.gameManager = gameManager
        self.userDefaults = userDefaults
    }

    var viewModel: GameBoardViewModel {
        GameBoardViewModel(dependency: self)
    }
}
