import UIKit

final class SearchResultRoomsHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [detailDescriptionLabel, roomCountLabel])
        stackView.axis = .vertical
        stackView.spacing = Margins.betweenLines
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            self.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
    }
    
    private let detailDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "5월 25일 ~ 5월 28일 ・ 게스트 3명"
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let roomCountLabel: UILabel = {
        let label = UILabel()
        label.text = "300개 이상의 숙소"
        label.font = UIFont.systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
