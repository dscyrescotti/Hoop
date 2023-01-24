import SwiftUI
import SpriteKit

public struct GameBoardView: View {
    @StateObject var viewModel: GameBoardViewModel

    private var gameBoardScene: SKScene

    public init(_ viewModel: GameBoardViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.gameBoardScene = GameBoardScene(viewModel)
    }

    public var body: some View {
        GeometryReader { proxy in
            SpriteView(
                scene: gameBoardScene,
                transition: .doorsCloseVertical(withDuration: 1),
                debugOptions: debugOptions
            )
            .onAppear {
                /// update the scene size to align with screen size
                gameBoardScene.size = proxy.size
            }
        }
        .ignoresSafeArea()
    }

    private var debugOptions: SpriteView.DebugOptions = {
        #if DEBUG
        [.showsDrawCount, .showsFPS, .showsFields, .showsNodeCount, .showsQuadCount]
        #else
        []
        #endif
    }()
}
