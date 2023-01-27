import SwiftUI
import SpriteKit

public struct GameBoardView: View {
    @StateObject var viewModel: GameBoardViewModel

    private var gameBoardScene: GameBoardScene

    public init(_ viewModel: GameBoardViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.gameBoardScene = GameBoardScene(viewModel)
    }

    public var body: some View {
        GeometryReader { proxy in
            SpriteView(
                scene: gameBoardScene,
                transition: .doorsCloseVertical(withDuration: 1),
                preferredFramesPerSecond: 200,
                debugOptions: debugOptions
            )
            .onAppear {
                /// update the scene size to align with screen size
                gameBoardScene.size = proxy.size
            }
        }
        .ignoresSafeArea()
        .overlay {
            if viewModel.gameState == .miss {
                gameOverAlert
                    .transition(.scale)
            }
        }
    }

    private var gameOverAlert: some View {
        VStack {
            Text("Game Over!")
            Button {
                viewModel.restartTrigger.send()
            } label: {
                Text("Restart")
            }
            Button {

            } label: {
                Text("Go to Home")
            }

        }
    }

    private var debugOptions: SpriteView.DebugOptions = {
        #if DEBUG
        [.showsDrawCount, .showsFPS, .showsFields, .showsNodeCount, .showsQuadCount]
        #else
        []
        #endif
    }()
}
