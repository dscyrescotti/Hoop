import Core
import SwiftUI

public class GameBoardViewModel: ObservableObject {
    let dependency: GameBoardDependency

    public init(dependency: GameBoardDependency) {
        self.dependency = dependency
    }
}
