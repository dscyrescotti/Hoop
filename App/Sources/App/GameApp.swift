import Routing
import SwiftUI

public struct GameApp: View {

    @Coordinator var coordinator

    public init() { }

    public var body: some View {
        VStack {
            Text("Game App")
            Button {
                $coordinator.present(.gameBoard)
            } label: {
                Text("Present")
            }

        }
        .coordinated($coordinator)
    }
}
