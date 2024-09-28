import Foundation

protocol SetPasswordViewModelDelegate: AnyObject {
    func viewModelDidUpdateItems(_ items: [SetPasswordViewModel.ConditionViewModel])
    func viewModelDidUpdateNextButtonState(isEnabled: Bool)
}

class SetPasswordViewModel {
    struct ConditionViewModel: Hashable {
        var text: String
        var isSelected: Bool
    }

    weak var delegate: SetPasswordViewModelDelegate?

    var password: String = "" {
        didSet {
            validate(password)
        }
    }
    var isLoading = false
    private(set) var items: [ConditionViewModel] = []
    private(set) var isNextButtonEnabled: Bool = false
    private let validator = PasswordValidator()

    init() {
        password = ""
        validate(password)
    }

    func didTapBack() {}

    func didTapNext() {}

    private func validate(_ password: String) {
        let result = validator.validate(password)
        
        items = [
            ConditionViewModel(text: "1 number", isSelected: result.isNumberPresent),
            ConditionViewModel(text: "1 capital letter", isSelected: result.isCapitalLetterPresent),
            ConditionViewModel(text: "1 special character", isSelected: result.isSpecialCharacterPresent),
            ConditionViewModel(text: "8+ characters", isSelected: result.isPasswordLongEnough),
        ]

        isNextButtonEnabled = result.isPasswordValid

        delegate?.viewModelDidUpdateItems(items)
        delegate?.viewModelDidUpdateNextButtonState(isEnabled: isNextButtonEnabled)
    }
}
