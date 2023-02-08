import Model
import Routing
import SwiftUI
import DesignSystem

public struct GameScoreView: View {
    @Coordinator var coordinator
    @StateObject var viewModel: GameScoreViewModel

    public init(dependency: GameScoreDependency) {
        self._viewModel = StateObject(wrappedValue: dependency.viewModel)
    }

    public var body: some View {
        VStack(spacing: 0) {
            NavBar(title: "High Scores") {
                $coordinator.dismiss()
            }
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(viewModel.scores, id: \.1) { index, score in
                        scoreRow(with: score, index: index + 1)
                    }
                }
                .padding(.vertical, 24)
            }
        }
        .background(Color.of(.deepChampagne), ignoresSafeAreaEdges: .all)
        .onAppear {
            viewModel.loadScores()
        }
    }

    @ViewBuilder
    func scoreRow(with score: Score, index: Int) -> some View {
        HStack(alignment: .bottom) {
            Text("#\(index)")
            trophyImage(index)
            Spacer()
            Text(score.points.formatted(.number))
        }
        .padding(15)
        .background(Color.of(.wheat))
        .cornerRadius(15)
        .overlay(alignment: .topLeading) {
            if score.date > Date().addingTimeInterval(-86400) && score.isNew {
                Text("New")
                    .font(.of(.caption))
                    .foregroundColor(.of(.white))
                    .padding(.vertical, 3)
                    .padding(.horizontal, 5)
                    .background(Capsule())
                    .foregroundColor(.of(.fireEngineRed))
            }
        }
        .padding(.horizontal, 24)
        .foregroundColor(.of(.rust))
        .font(.of(.headline3))
    }

    @ViewBuilder
    func trophyImage(_ index: Int) -> some View {
        switch index {
        case 1:
            Image.loadImage(.goldTrophy)
                .resizable()
                .frame(width: 40, height: 40)
        case 2:
            Image.loadImage(.silverTrophy)
                .resizable()
                .frame(width: 40, height: 40)
        case 3:
            Image.loadImage(.bronzeTrophy)
                .resizable()
                .frame(width: 40, height: 40)
        default:
            EmptyView()
        }
    }
}
