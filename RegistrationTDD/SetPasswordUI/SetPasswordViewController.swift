import UIKit

class SetPasswordViewController: UIViewController {
    private let viewModel = SetPasswordViewModel()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 29, weight: .bold)
        return label
    }()

    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Enter your password"
        textField.isSecureTextEntry = true
        return textField
    }()

    private let passwordInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Password should contain:"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return label
    }()

    private let conditionsFlowLayout = FlowLayout()

    private let nextButton: PrimaryButton = {
        let button = PrimaryButton()
        button.setTitle("Next", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.delegate = self
        viewModel.password = ""
    }

    private func setupUI() {
        view.backgroundColor = .black

        view.addSubview(titleLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordInfoLabel)
        view.addSubview(conditionsFlowLayout)
        view.addSubview(nextButton)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionsFlowLayout.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            passwordTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 54),

            passwordInfoLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            passwordInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            conditionsFlowLayout.topAnchor.constraint(equalTo: passwordInfoLabel.bottomAnchor, constant: 8),
            conditionsFlowLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            conditionsFlowLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }

    private func setupBindings() {
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }

    @objc private func passwordTextFieldDidChange() {
        viewModel.password = passwordTextField.text ?? ""
    }

    @objc private func nextButtonTapped() {
        viewModel.didTapNext()
    }
}

extension SetPasswordViewController: SetPasswordViewModelDelegate {
    func viewModelDidUpdateItems(_ items: [SetPasswordViewModel.ConditionViewModel]) {
        conditionsFlowLayout.configure(with: items)
    }

    func viewModelDidUpdateNextButtonState(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
    }
}
