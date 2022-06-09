import UIKit

final class ReservationPriceTableViewCell: UITableViewCell {
    
    static let identifier: String = "ReservationPriceTableViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 18)
        label.sizeToFit()
        label.text = "Title"
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Value"
        label.sizeToFit()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(valueLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            titleLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5),
            
            valueLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            valueLabel.bottomAnchor.self.constraint(equalTo: self.contentView.bottomAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
    
    func updateLabelText(priceTitle title: String, priceValue value: String) {
        self.titleLabel.text = title
        self.valueLabel.text = value
    }
}
