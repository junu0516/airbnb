import UIKit

final class RoomPositionMapCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RoomPositionMapCollectionViewCell"
    
    private lazy var roomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var reviewView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var starLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "★"
        label.textColor = .red
        return label
    }()
    
    private lazy var starCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var reviewCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .systemBackground
        self.addComponentViews()
        self.setCompoentLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponentViews() {
        self.contentView.addSubview(roomImageView)
        self.contentView.addSubview(reviewView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(priceLabel)
        
        self.reviewView.addSubview(starLabel)
        self.reviewView.addSubview(starCountLabel)
        self.reviewView.addSubview(reviewCountLabel)
    }
    
    private func setCompoentLayout() {
        NSLayoutConstraint.activate([
            roomImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            roomImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            roomImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            roomImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.4),
            
            reviewView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            reviewView.leadingAnchor.constraint(equalTo: roomImageView.trailingAnchor, constant: 15),
            reviewView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            reviewView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.2),
            
            starLabel.topAnchor.constraint(equalTo: reviewView.topAnchor),
            starLabel.leadingAnchor.constraint(equalTo: reviewView.leadingAnchor),
            starLabel.bottomAnchor.constraint(equalTo: reviewView.bottomAnchor),
            
            starCountLabel.topAnchor.constraint(equalTo: reviewView.topAnchor),
            starCountLabel.leadingAnchor.constraint(equalTo: starLabel.trailingAnchor, constant: 5),
            starCountLabel.bottomAnchor.constraint(equalTo: reviewView.bottomAnchor),
            
            reviewCountLabel.topAnchor.constraint(equalTo: reviewView.topAnchor),
            reviewCountLabel.leadingAnchor.constraint(equalTo: starCountLabel.trailingAnchor, constant: 5),
            reviewCountLabel.bottomAnchor.constraint(equalTo: reviewView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: reviewView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: roomImageView.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: roomImageView.trailingAnchor, constant: 15),
            priceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
    
    func updateInfo(title: String, price: String, starCount: String, reviewCount: String) {
        self.titleLabel.text = title
        self.priceLabel.text = "₩\(price) / 박"
        self.starCountLabel.text = starCount
        self.reviewCountLabel.text = "(후기 \(reviewCount)개)"
    }
}
