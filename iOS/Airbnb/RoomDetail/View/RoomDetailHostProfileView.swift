import UIKit

final class RoomDetailHostProfileView: UIView {
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
    
    func updateViews(hostName: String, maxNumberOfPeople: Int, styleOfRoom: String, bedCount: Int, bathroomCount: Int) {
        hostNameLabel.text = hostName
        roomInformationLabel.text = "최대인원 \(maxNumberOfPeople)명, \(styleOfRoom), 침대\(bedCount)개, 욕실\(bathroomCount)개"
    }
    
    func updateImageView(data: Data) {
        self.imageView.image = UIImage(data: data)
    }
    
    private func makeStackView(with views: [UIView], axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func setupViews() {
        
        let titleStackView = makeStackView(with: [titleLabel, hostNameLabel], axis: .vertical)
        let innerStackView = makeStackView(with: [titleStackView, imageView], axis: .horizontal)
        
        let stackView = UIStackView(arrangedSubviews: [innerStackView, roomInformationLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: Margins.top, left: Margins.side, bottom: Margins.bottom, right: Margins.side)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: stackView.topAnchor),
            self.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            
            self.imageView.widthAnchor.constraint(equalToConstant: 56),
            self.imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        
        imageView.layer.cornerRadius = 56/2
        imageView.clipsToBounds = true
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "레지던스 전체"
        label.font = .systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let hostNameLabel: UILabel = {
        let label = UILabel()
        label.text = "님"
        label.font = .systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let roomInformationLabel: UILabel = {
        let label = UILabel()
        label.text = "최대인원 0명, 원룸, 침대0개, 욕실0개"
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}
