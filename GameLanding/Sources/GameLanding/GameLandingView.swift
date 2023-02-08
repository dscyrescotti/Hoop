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
        .coordinated($coordinator)
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
                .scaleEffect(x: viewModel.isAnimateTitle ? 1 : 1.5, y: viewModel.isAnimateTitle ? 1 : 1.5)
                .animation(.easeOut(duration: 1.6).repeatForever(), value: viewModel.isAnimateTitle)
                .rotationEffect(.degrees(viewModel.isAnimateTitle ? 5 : -5))
                .animation(.easeIn(duration: 0.8).repeatForever(), value: viewModel.isAnimateTitle)
            Text("Shoot Your Shot 🏀💨")
                .font(.of(.headline))
                .foregroundColor(.of(.mahogany))
                .offset(x: viewModel.isAnimateTitle ? -proxy.size.width * 0.8 : proxy.size.width * 0.8)
                .animation(.linear(duration: 5).repeatForever(autoreverses: false), value: viewModel.isAnimateTitle)
        }
    }

    private var buttons: some View {
        VStack(spacing: 15) {
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
                $coordinator.fullScreen(.gameScore)
            } label: {
                Label {
                    Text("Top Scores")
                } icon: {
                    Image.loadImage(.alignVerticalBottomFill)
                }
            }
        }
        .buttonStyle(.primary)
    }
}
