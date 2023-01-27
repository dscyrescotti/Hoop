import Core
import SwiftUI
import GameBoard

@main
struct HoopApp: App {
    let gameManager: GameManager = GameManager()
    var body: some Scene {
        WindowGroup {
            GameBoardView(GameBoardViewModel(dependency: .init(gameManager: gameManager)))
        }
    }
}
