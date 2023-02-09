import Model
import Routing
import SwiftUI
import DesignSystem

public struct GameLandingView: View {
    @Coordinator var coordinator
    @StateObject var viewModel: GameLandingViewModel

    public init(dependency: GameLandingDependency) {
        self._viewModel = StateObject(wrappedValue: dependency.viewModel)
    }

    public var body: some View {
        GeometryReader { proxy in
            VStack {
                headingImage
                header(proxy: proxy)
                Spacer()
                Spacer()
                buttons
                Spacer()
            }
            .padding(24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color.of(.deepChampagne), ignoresSafeAreaEdges: .all)
        .onAppear {
            viewModel.startAnimation()
        }
        .coordinated($coordinator) {
            viewModel.updateSelectedBall()
        }
    }

    private var headingImage: some View {
        Image.loadImage(.ballPassingHoop)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 170)
    }

    private func header(proxy: GeometryProxy) -> some View {
        VStack(spacing: 20) {
            Text("Hoop")
                .font(.of(.heading))
                .foregroundColor(.of(.rust))
                .scaleEffect(x: viewModel.startsAnimation ? 1 : 1.5, y: viewModel.startsAnimation ? 1 : 1.5)
                .animation(.easeOut(duration: 1.6).repeatForever(), value: viewModel.startsAnimation)
                .rotationEffect(.degrees(viewModel.startsAnimation ? 5 : -5))
                .animation(.easeIn(duration: 0.8).repeatForever(), value: viewModel.startsAnimation)
            Text("Shoot Your Shot 🏀💨")
                .font(.of(.headline))
                .foregroundColor(.of(.mahogany))
                .offset(x: viewModel.startsAnimation ? -proxy.size.width * 0.8 : proxy.size.width * 0.8)
                .animation(.linear(duration: 5).repeatForever(autoreverses: false), value: viewModel.startsAnimation)
        }
    }

    private var buttons: some View {
        VStack(alignment: .trailing, spacing: 15) {
            Button {
                $coordinator.switchScreen(.gameBoard(mode: .new))
            } label: {
                Label {
                    Text("New Game")
                } icon: {
                    Image.loadImage(.gamecontrollerFill)
                }
            }
            if viewModel.isExistsGame {
                Button {
                    $coordinator.switchScreen(.gameBoard(mode: .existing))
                } label: {
                    Label {
                        Text("Continue")
                    } icon: {
                        Image.loadImage(.playCircleFill)
                    }
                }
            }
            Button {
                $coordinator.fullScreen(.ballPicker)
            } label: {
                Label {
                    Text("Select Ball")
                } icon: {
                    Image.loadBall(viewModel.selectedBall.rawValue)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .scaleEffect(x: viewModel.startsAnimation ? 1 : 0.8, y: viewModel.startsAnimation ? 1 : 0.8)
                        .animation(.easeInOut.repeatForever(), value: viewModel.startsAnimation)
                        .rotationEffect(viewModel.startsAnimation ? .degrees(0) : .degrees(360))
                        .animation(.linear(duration: 5).repeatForever(autoreverses: false), value: viewModel.startsAnimation)
                }
            }
            Button {
                viewModel.resetScoreCount()
                $coordinator.fullScreen(.gameScore)
            } label: {
                Label {
                    Text("High Scores")
                } icon: {
                    Image.loadImage(.alignVerticalBottomFill)
                }
            }
            .overlay(alignment: .topLeading) {
                if viewModel.newScoreCount > 0 {
                    NewBadge(.flame)
                }
            }
            .onAppear {
                viewModel.loadScoreCount()
            }
        }
        .buttonStyle(.primary)
    }
}
