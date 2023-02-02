import Core
import GameBoard
import GameLanding

public struct Environment {
    let gameManager: GameManager

    init(gameManager: GameManager) {
        self.gameManager = gameManager
    }
}

extension Environment {
    static var live: Environment = {
        let gameManager = GameManager()
        return Environment(gameManager: gameManager)
    }()
}

extension Environment {
    var gameBoardDependency: GameBoardDependency {
        GameBoardDependency(gameManager: gameManager)
    }

    var gameLandingDependency: GameLandingDependency {
        GameLandingDependency(gameManager: gameManager)
    }
}
