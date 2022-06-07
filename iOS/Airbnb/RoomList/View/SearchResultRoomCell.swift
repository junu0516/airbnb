import UIKit

final class SearchResultRoomCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateImageView(imageData: Data) {
        self.thumbnailImageView.image = UIImage(data: imageData)
    }
    
    func updateViews(title: String, numberOfReviews: Int, averageOfStar: Float, pricePerDay: Int, totalPrice: Int) {
        self.titleLabel.text = title
        self.reviewLabel.text = "\(averageOfStar) (후기 \(numberOfReviews)개)"
        self.priceOneDayLabel.text = "₩\(pricePerDay) /박"
        self.totalPriceLabel.text = "총액 ₩\(totalPrice)"
    }

    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textColor = .airbnbGray1
        return label
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0(후기 0개)"
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .airbnbGray3
        return label
    }()
    
    private let priceOneDayLabel: UILabel = {
        let label = UILabel()
        label.text = "₩ 0 /박"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .airbnbGray1
        return label
    }()
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "총액 ₩"
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .airbnbGray3
        return label
    }()
    
    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [thumbnailImageView, reviewLabel, titleLabel, priceOneDayLabel, totalPriceLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = Margins.betweenLines
        
        @CodableLayoutView(view: stackView) var layoutStackView
        @CodableLayoutView(view: thumbnailImageView) var layoutThumbnailImageView
        
        self.addSubview(layoutStackView)
        NSLayoutConstraint.activate([
            layoutStackView.topAnchor.constraint(equalTo: topAnchor),
            layoutStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            layoutStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            layoutStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            layoutThumbnailImageView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        let thumbnailImageAutolayout = layoutThumbnailImageView.heightAnchor.constraint(equalTo: layoutThumbnailImageView.widthAnchor, multiplier: 0.7)
        thumbnailImageAutolayout.priority = .defaultLow
        thumbnailImageAutolayout.isActive = true
        layoutThumbnailImageView.clipsToBounds = true
        layoutThumbnailImageView.layer.cornerRadius = 10
    }
}
