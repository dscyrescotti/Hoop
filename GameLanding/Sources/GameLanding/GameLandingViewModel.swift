import Combine

public class GameLandingViewModel: ObservableObject {
    let dependency: GameLandingDependency

    @Published var isAnimateTitle: Bool = false

    public init(dependency: GameLandingDependency) {
        self.dependency = dependency
    }

    func startAnimation() {
        isAnimateTitle = true
    }
}
