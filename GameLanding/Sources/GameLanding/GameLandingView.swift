import SwiftUI
import DesignSystem

public struct GameLandingView: View {
    @StateObject var viewModel: GameLandingViewModel

    public init(_ viewModel: GameLandingViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        GeometryReader { proxy in
            VStack {
                Image.loadImage(.ballPassingHoop)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 170)
                Text("Hoop")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.of(.rust))
                    .scaleEffect(x: viewModel.isAnimateTitle ? 1 : 1.5, y: viewModel.isAnimateTitle ? 1 : 1.5)
                    .animation(.easeOut(duration: 1.6).repeatForever(), value: viewModel.isAnimateTitle)
                    .rotationEffect(.degrees(viewModel.isAnimateTitle ? 5 : -5))
                    .animation(.easeIn(duration: 0.8).repeatForever(), value: viewModel.isAnimateTitle)
                Text("Shoot Your Shot 🏀💨")
                    .font(.title2.bold())
                    .foregroundColor(.of(.mahogany))
                    .padding(.top, 2)
                    .offset(x: viewModel.isAnimateTitle ? -proxy.size.width * 0.8 : proxy.size.width * 0.8)
                    .animation(.linear(duration: 5).repeatForever(autoreverses: false), value: viewModel.isAnimateTitle)
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
}
