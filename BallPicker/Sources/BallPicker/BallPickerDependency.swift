import Defaults

public struct BallPickerDependency {
    let userDefaults: UserDefaultService

    public init(userDefaults: UserDefaultService) {
        self.userDefaults = userDefaults
    }

    var viewModel: BallPickerViewModel {
        BallPickerViewModel(dependency: self)
    }
}
