import Core
import Model
import SwiftUI

public class GameBoardViewModel: ObservableObject {
    let dependency: GameBoardDependency

    @Published var gameState: GameState = .idle

    var ball: Ball { dependency.gameManager.ball }
    var hoops: Hoops { dependency.gameManager.hoops }

    public init(dependency: GameBoardDependency) {
        self.dependency = dependency
    }

    func loadGame(on frame: CGRect) {
        dependency.gameManager.loadNewGame(on: frame)
    }
}
