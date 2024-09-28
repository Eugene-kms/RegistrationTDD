import UIKit

class FlowLayout: UIView {
    private var labels: [UILabel] = []

    func configure(with items: [SetPasswordViewModel.ConditionViewModel]) {
        // Remove existing labels
        labels.forEach { $0.removeFromSuperview() }
        labels.removeAll()

        // Create new labels
        for item in items {
            let label = UILabel()
            label.text = item.text
            label.textColor = item.isSelected ? .white : .gray
            label.font = UIFont.systemFont(ofSize: 15)
            label.textAlignment = .center
            label.layer.borderWidth = 1
            label.layer.borderColor = item.isSelected ? UIColor.white.cgColor : UIColor.gray.cgColor
            label.layer.cornerRadius = 8
            label.clipsToBounds = true
            label.sizeToFit()
            label.frame.size.width += 20 // Add some padding
            label.frame.size.height += 8 // Add some padding
            labels.append(label)
            addSubview(label)
        }

        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        var currentOriginX: CGFloat = 0
        var currentOriginY: CGFloat = 0
        let padding: CGFloat = 6

        for label in labels {
            if currentOriginX + label.frame.width > bounds.width {
                currentOriginX = 0
                currentOriginY += label.frame.height + padding
            }

            label.frame.origin = CGPoint(x: currentOriginX, y: currentOriginY)
            currentOriginX += label.frame.width + padding
        }
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: labels.last?.frame.maxY ?? 0)
    }
}
