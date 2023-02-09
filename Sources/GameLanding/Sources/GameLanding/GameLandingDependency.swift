import Core
import Defaults

public struct GameLandingDependency {
    let gameManager: GameManager
    let userDefaults: UserDefaultService

    public init(gameManager: GameManager, userDefaults: UserDefaultService) {
        self.gameManager = gameManager
        self.userDefaults = userDefaults
    }

    var viewModel: GameLandingViewModel {
        GameLandingViewModel(dependency: self)
    }
}
