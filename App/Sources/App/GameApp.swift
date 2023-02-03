import Routing
import SwiftUI
import GameLanding

public struct GameApp: View {
    @Coordinator var coordinator

    public init() { }

    public var body: some View {
        RootView($coordinator)
            .onAppear {
                $coordinator.switchScreen(.gameBoard)
            }
    }
}
