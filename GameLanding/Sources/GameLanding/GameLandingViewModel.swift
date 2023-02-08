import Combine

class GameLandingViewModel: ObservableObject {
    let dependency: GameLandingDependency

    @Published var isAnimateTitle: Bool = false
    @Published var newScoreCount: Int = 0

    var isExistsGame: Bool {
        dependency.gameManager.isExistsGame
    }

    public init(dependency: GameLandingDependency) {
        self.dependency = dependency
    }

    func startAnimation() {
        isAnimateTitle = true
    }

    func loadScoreCount() {
        newScoreCount = dependency.gameManager.loadNewScoreObjectCount()
    }

    func resetScoreCount() {
        newScoreCount = 0
    }
}
