import UIKit

final class ConditionSettingTableViewCell: UITableViewCell {
    
    static let identifier: String = "ConditionSettingTableViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    convenience init(conditionTitle title: String, conditionValue value: String) {
        self.init()
        addComponentViews()
        setComponentLayouts()
    }
    
    func updateLabelText(conditionTitle title: String, conditionValue value: String) {
        self.titleLabel.text = title
        self.valueLabel.text = value
    }
    
    private func addComponentViews() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(valueLabel)
    }
    
    private func setComponentLayouts() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            titleLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5),
            
            valueLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
}
