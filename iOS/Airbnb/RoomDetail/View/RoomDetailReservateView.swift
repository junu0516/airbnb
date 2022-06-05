import UIKit

final class RoomDetailReservateView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray6
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateViews(priceForOneDay: Int) {
        priceOneDayLabel.text = "₩ \(priceForOneDay) /박"
    }
    
    private let priceOneDayLabel: UILabel = {
        let label = UILabel()
        label.text = "₩ 0 /박"
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectDateLabel: UILabel = {
        let label = UILabel()
        label.text = "0월 0일 ~ 0월 0일"
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("예약하기", for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [priceOneDayLabel, selectDateLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        addSubview(button)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
    }
}
