import UIKit

final class RoomDetailDescriptionView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.createLine(position: .bottom)
    }
    
    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [contentLabel, moreButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: DetailViewMargins.top, left: DetailViewMargins.side, bottom: DetailViewMargins.bottom, right: DetailViewMargins.side)
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: stackView.topAnchor),
            self.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
    }
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = """
                    강남역 5번출구에서 도보로 이동가능합니다 지하철, 버스노선이 다양하고 맛집, 마트 등 주변 시설이 풍부합니다. 깨끗하고, 아늑한 시설을 만끽해보세요 어쩌구 저쩌구
                    """
        label.numberOfLines = 3
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
}
