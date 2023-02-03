import Routing
import SwiftUI

public struct GameScoreView: View {
    @Coordinator var coordinator
    @StateObject var viewModel: GameScoreViewModel

    public init(dependency: GameScoreDependency) {
        self._viewModel = StateObject(wrappedValue: dependency.viewModel)
    }

    public var body: some View {
        VStack {
            Text("See Your Top Scores! Coming Soon.")
            Button {
                $coordinator.dismiss()
            } label: {
                Text("Dismiss")
            }
        }
    }
}
