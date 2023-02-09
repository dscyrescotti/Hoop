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
            if viewModel.gameState == .pause {
                resumeAlert
                    .transition(.scale)
            }
        }
        .overlay(alignment: .top) {
            HStack(alignment: .top) {
                Button {
                    viewModel.pauseGame()
                } label: {
                    Image.loadImage(viewModel.gameState == .pause ? .playFill : .pauseFill)
                }
                .disabled(viewModel.gameState != .idle)
                .foregroundColor(.of(.mahogany))
                .font(.of(.headline3))
                .buttonStyle(.default)
                Spacer()
                VStack(alignment: .trailing, spacing: 5) {
                    HStack {
                        ForEach(0..<3, id: \.self) { index in
                            Image.loadImage(.heart)
                                .resizable()
                                .contrast(viewModel.lives + index > 2 ? 1 : 0)
                                .frame(width: 30, height: 30)
                        }
                    }
                    HStack {
                        Text(viewModel.points, format: .number)
                        Image.loadImage(.trophy)
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .padding(.top, 5)
                    Text("x")
                        .font(.of(.headline))
                    +
                    Text("\(max(viewModel.winningSteak, 1))")
                }
            }
            .font(.of(.headline3))
            .multilineTextAlignment(.trailing)
            .foregroundColor(.of(.rust))
            .padding(.horizontal, 20)
        }
    }

    private var gameOverAlert: some View {
        VStack(spacing: 15) {
            Text("Game Over!")
                .font(.of(.largeTitle))
                .foregroundColor(.of(.eerieBlack))
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
                viewModel.cleanUpGameBoard()
                $coodinator.switchScreen(.gameLanding)
            } label: {
                Label {
                    Text("Return Home")
                } icon: {
                    Image.loadImage(.house)
                }
            }
        }
        .buttonStyle(.primary)
        .padding(24)
        .background(Color.of(.deepChampagne))
        .cornerRadius(15)
        .padding(.horizontal, 24)
    }

    private var resumeAlert: some View {
        VStack(spacing: 15) {
            Text("Game Paused!")
                .font(.of(.largeTitle))
                .foregroundColor(.of(.eerieBlack))
            Button {
                viewModel.resumeGame()
            } label: {
                Label {
                    Text("Resume")
                } icon: {
                    Image.loadImage(.playFill)
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
            Button {
                viewModel.cleanUpGameBoard()
                $coodinator.switchScreen(.gameLanding)
            } label: {
                Label {
                    Text("Abort Game")
                } icon: {
                    Image.loadImage(.trashFill)
                }
            }
        }
        .buttonStyle(.primary)
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
