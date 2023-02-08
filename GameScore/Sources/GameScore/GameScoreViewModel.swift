import Model
import SwiftUI

class GameScoreViewModel: ObservableObject {
    let dependency: GameScoreDependency

    @Published var scores: [(Int, Score)] = []

    public init(dependency: GameScoreDependency) {
        self.dependency = dependency
    }

    func loadScores() {
        scores = dependency.gameManager.scores.enumerated().map { ($0, $1) }
        dependency.gameManager.updateScores()
    }
}
