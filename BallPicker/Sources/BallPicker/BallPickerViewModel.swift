import Core
import Model
import SwiftUI

class BallPickerViewModel: ObservableObject {
    let dependency: BallPickerDependency
    let balls: BallStyles = .all

    @Published var selectedBall: BallStyle

    public init(dependency: BallPickerDependency) {
        self.dependency = dependency
        self.selectedBall = dependency.userDefaults.fetch(for: \.ball)
    }

    func selectBall(_ ball: BallStyle) {
        withAnimation {
            self.selectedBall = ball
        }
        dependency.userDefaults.save(ball, for: \.ball)
    }
}
