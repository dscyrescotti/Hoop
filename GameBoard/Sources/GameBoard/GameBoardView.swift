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
        VStack(spacing: 15) {
            Text("Game Over!")
                .font(.title.bold())
                .foregroundColor(.black)
            Button {
                viewModel.restartTrigger.send()
            } label: {
                Label {
                    Text("Restart")
                } icon: {
                    Image.loadImage(.arrowCounterclockwise)
                }
            }
            Button {

            } label: {
                Label {
                    Text("Return Home")
                } icon: {
                    Image.loadImage(.house)
                }
            }
        }
        .buttonStyle(.springButtonStyle)
        .padding(24)
        .background(Color.of(.deepChampagne))
        .cornerRadius(15)
        .padding(.horizontal, 24)
    }

    private var debugOptions: SpriteView.DebugOptions = {
        #if DEBUG
        [.showsDrawCount, .showsFPS, .showsFields, .showsNodeCount, .showsQuadCount]
        #else
        []
        #endif
    }()
}
