import Core
import SwiftUI
import GameLanding

@main
struct HoopApp: App {
    let gameManager: GameManager = GameManager()
    var body: some Scene {
        WindowGroup {
//            GameBoardView(GameBoardViewModel(dependency: .init(gameManager: gameManager)))
            GameLandingView(GameLandingViewModel(dependency: .init(gameManager: gameManager)))
        }
    }
}
