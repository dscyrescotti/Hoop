import Model
import Routing
import SwiftUI
import DesignSystem

public struct BallPickerView: View {
    @Coordinator var coordinator
    @StateObject var viewModel: BallPickerViewModel

    public init(dependency: BallPickerDependency) {
        self._viewModel = StateObject(wrappedValue: dependency.viewModel)
    }

    var colums: [GridItem] = {
        Array(
            repeating: GridItem(.flexible(), spacing: 20),
            count: 3
        )
    }()

    public var body: some View {
        VStack(spacing: 0) {
            NavBar(title: "Basketballs") {
                $coordinator.dismiss()
            }
            GeometryReader { proxy in
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: colums, spacing: 20) {
                        ForEach(viewModel.balls) { ball in
                            ballGridView(ball, in: proxy)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 20)
                }
            }
        }
        .background(Color.of(.deepChampagne), ignoresSafeAreaEdges: .all)
    }

    @ViewBuilder
    private func ballGridView(_ ball: BallStyle, in proxy: GeometryProxy) -> some View {
        let size = proxy.size.width / 3 - 40
        Button {
            viewModel.selectBall(ball)
        } label: {
            Image.loadBall(ball.rawValue)
                .frame(maxWidth: size, minHeight: size)
                .background(Color.of(.peach))
                .cornerRadius(15)
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.of(.flame), lineWidth: 4)
                }
        }
        .buttonStyle(.default)
        .disabled(ball == viewModel.selectedBall)
        .overlay(alignment: .bottom) {
            if ball == viewModel.selectedBall {
                Label {
                    Text("Selected")
                } icon: {
                    Image.loadImage(.checkmarkCircleFill)
                }
                .font(.of(.caption2))
                .foregroundColor(.of(.olive))
                .padding(3)
                .background {
                    Capsule()
                        .foregroundColor(.of(.wheat))
                }
                .offset(y: 10)
                .transition(.scale)
            }
        }
    }
}
