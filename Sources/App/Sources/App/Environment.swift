import Core
import Model
import Defaults
import GameBoard
import GameScore
import BallPicker
import GameLanding
import Persistency
import DesignSystem

public struct Environment {
    let gameManager: GameManager
    let persistency: PersistencyService
    let userDefaults: UserDefaultService

    init(
        gameManager: GameManager,
        persistency: PersistencyService,
        userDefaults: UserDefaultService
    ) {
        self.gameManager = gameManager
        self.persistency = persistency
        self.userDefaults = userDefaults
    }
}

extension Environment {
    static var live: Environment = {
        DesignSystem.load()
        let persistency = PersistencyService()
        let userDefaults = UserDefaultService()
        let gameManager = GameManager(persistency: persistency)
        return Environment(
            gameManager: gameManager,
            persistency: persistency,
            userDefaults: userDefaults
        )
    }()
}

extension Environment {
    func gameBoardDependency(_ gameMode: GameMode) -> GameBoardDependency {
        GameBoardDependency(
            gameMode: gameMode,
            gameManager: gameManager,
            userDefaults: userDefaults
        )
    }
    
    var gameScoreDependency: GameScoreDependency {
        GameScoreDependency(gameManager: gameManager)
    }

    var gameLandingDependency: GameLandingDependency {
        GameLandingDependency(
            gameManager: gameManager,
            userDefaults: userDefaults
        )
    }

    var ballPickerDependency: BallPickerDependency {
        BallPickerDependency(userDefaults: userDefaults)
    }
}
