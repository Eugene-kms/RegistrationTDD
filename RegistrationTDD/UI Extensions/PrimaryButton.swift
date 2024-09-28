import UIKit

class PrimaryButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    private func setupButton() {
        backgroundColor = .tintColor
        setTitleColor(.white, for: .normal)
        setTitleColor(.gray, for: .disabled)
        titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        layer.cornerRadius = 8
    }

    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? .blue : .black
            layer.borderColor = isEnabled ? UIColor.blue.cgColor : UIColor.black.withAlphaComponent(0.5).cgColor
            alpha = isEnabled ? 1.0 : 0.5
        }
    }
}
