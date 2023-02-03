import Core
import GameBoard
import GameScore
import GameLanding
import DesignSystem

public struct Environment {
    let gameManager: GameManager

    init(gameManager: GameManager) {
        self.gameManager = gameManager
    }
}

extension Environment {
    static var live: Environment = {
        DesignSystem.load()
        let gameManager = GameManager()
        return Environment(gameManager: gameManager)
    }()
}

extension Environment {
    var gameBoardDependency: GameBoardDependency {
        GameBoardDependency(gameManager: gameManager)
    }
    
    var gameScoreDependency: GameScoreDependency {
        GameScoreDependency(gameManager: gameManager)
    }

    var gameLandingDependency: GameLandingDependency {
        GameLandingDependency(gameManager: gameManager)
    }
}
