import Combine

class GameLandingViewModel: ObservableObject {
    let dependency: GameLandingDependency

    @Published var isAnimateTitle: Bool = false

    var isExistsGame: Bool {
        dependency.gameManager.isExistsGame
    }

    public init(dependency: GameLandingDependency) {
        self.dependency = dependency
    }

    func startAnimation() {
        isAnimateTitle = true
    }
}
