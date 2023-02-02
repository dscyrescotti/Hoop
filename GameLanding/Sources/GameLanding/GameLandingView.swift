import SwiftUI
import DesignSystem

public struct GameLandingView: View {
    @StateObject var viewModel: GameLandingViewModel

    public init(dependency: GameLandingDependency) {
        self._viewModel = StateObject(wrappedValue: dependency.viewModel)
    }

    public var body: some View {
        GeometryReader { proxy in
            VStack {
                Image.loadImage(.ballPassingHoop)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 170)
                header(proxy: proxy)
                Spacer()
                Spacer()
            }
            .padding(24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color.of(.deepChampagne), ignoresSafeAreaEdges: .all)
        .onAppear {
            viewModel.startAnimation()
        }
    }

    private func header(proxy: GeometryProxy) -> some View {
        VStack(spacing: 20) {
            Text("Hoop")
                .font(.system(size: 60, weight: .bold))
                .foregroundColor(.of(.rust))
                .scaleEffect(x: viewModel.isAnimateTitle ? 1 : 1.5, y: viewModel.isAnimateTitle ? 1 : 1.5)
                .animation(.easeOut(duration: 1.6).repeatForever(), value: viewModel.isAnimateTitle)
                .rotationEffect(.degrees(viewModel.isAnimateTitle ? 5 : -5))
                .animation(.easeIn(duration: 0.8).repeatForever(), value: viewModel.isAnimateTitle)
            Text("Shoot Your Shot 🏀💨")
                .font(.title.bold())
                .foregroundColor(.of(.mahogany))
                .offset(x: viewModel.isAnimateTitle ? -proxy.size.width * 0.8 : proxy.size.width * 0.8)
                .animation(.linear(duration: 5).repeatForever(autoreverses: false), value: viewModel.isAnimateTitle)
        }
    }
}
