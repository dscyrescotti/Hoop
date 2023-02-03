import Routing
import SwiftUI
import SpriteKit

public struct GameBoardView: View {
    @Coordinator var coodinator
    @StateObject var viewModel: GameBoardViewModel

    private var gameBoardScene: GameBoardScene

    public init(dependency: GameBoardDependency) {
        let viewModel = dependency.viewModel
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.gameBoardScene = GameBoardScene(viewModel)
    }

    public var body: some View {
        GeometryReader { proxy in
            SpriteView(
                scene: gameBoardScene,
                transition: .doorsCloseVertical(withDuration: 1),
                preferredFramesPerSecond: 60,
                debugOptions: debugOptions
            )
            .onAppear {
                /// update the scene size to align with screen size
                gameBoardScene.size = proxy.size
            }
        }
        .ignoresSafeArea()
        .overlay {
            if viewModel.gameState == .gameOver {
                gameOverAlert
                    .transition(.scale)
            }
        }
        .overlay(alignment: .top) {
            HStack(alignment: .top) {
                HStack {
                    ForEach(0..<viewModel.lives, id: \.self) { _ in
                        Image.loadImage(.heartFill)
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                }
                .padding(.vertical, 5)
                Spacer()
                VStack(alignment: .trailing, spacing: 5) {
                    HStack {
                        Text(viewModel.points, format: .number)
                        Image.loadImage(.basketball)
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    Text("x\(max(viewModel.winningSteak, 1))")
                }
            }
            .font(.title.bold())
            .multilineTextAlignment(.trailing)
            .foregroundColor(.of(.rust))
            .padding(.horizontal, 20)
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
                $coodinator.switchScreen(.gameLanding)
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
