import Model
import Combine
import Defaults

class GameLandingViewModel: ObservableObject {
    let dependency: GameLandingDependency

    @Published var startsAnimation: Bool = false
    @Published var newScoreCount: Int = 0
    @Published var selectedBall: BallStyle

    var isExistsGame: Bool {
        dependency.gameManager.isExistsGame
    }

    public init(dependency: GameLandingDependency) {
        self.dependency = dependency
        self.selectedBall = dependency.userDefaults.fetch(for: \.ball)
    }

    func startAnimation() {
        startsAnimation = true
    }

    func loadScoreCount() {
        newScoreCount = dependency.gameManager.loadNewScoreObjectCount()
    }

    func resetScoreCount() {
        newScoreCount = 0
    }

    func updateSelectedBall() {
        self.selectedBall = dependency.userDefaults.fetch(for: \.ball)
    }
}
