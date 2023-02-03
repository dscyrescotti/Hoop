import SwiftUI

class GameScoreViewModel: ObservableObject {
    let dependency: GameScoreDependency

    public init(dependency: GameScoreDependency) {
        self.dependency = dependency
    }
}
