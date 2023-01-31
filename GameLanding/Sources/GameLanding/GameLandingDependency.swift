import Core

public struct GameLandingDependency {
    let gameManager: GameManager

    public init(gameManager: GameManager) {
        self.gameManager = gameManager
    }
}
