import Core
import Model
import GameBoard
import GameScore
import GameLanding
import Persistency
import DesignSystem

public struct Environment {
    let gameManager: GameManager
    let persistency: PersistencyService

    init(
        gameManager: GameManager,
        persistency: PersistencyService
    ) {
        self.gameManager = gameManager
        self.persistency = persistency
    }
}

extension Environment {
    static var live: Environment = {
        DesignSystem.load()
        let persistency = PersistencyService()
        let gameManager = GameManager(persistency: persistency)
        return Environment(
            gameManager: gameManager,
            persistency: persistency
        )
    }()
}

extension Environment {
    func gameBoardDependency(_ gameMode: GameMode) -> GameBoardDependency {
        GameBoardDependency(
            gameMode: gameMode,
            gameManager: gameManager
        )
    }
    
    var gameScoreDependency: GameScoreDependency {
        GameScoreDependency(gameManager: gameManager)
    }

    var gameLandingDependency: GameLandingDependency {
        GameLandingDependency(gameManager: gameManager)
    }
}
