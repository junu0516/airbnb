import UIKit

struct DetailViewMargins {
    static let side: CGFloat = 16
    static let top: CGFloat = 24
    static let bottom: CGFloat = 24
}


final class RoomDetailViewController: UIViewController {
    
    private let useCase: RoomDetailUseCase
    
    init(useCase: RoomDetailUseCase) {
        self.useCase = useCase
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
        useCase.initialize()
        bindView()
        
        shareButton.addTarget(self, action: #selector(touchedShareButton), for: .touchUpInside)
        
        closeButton.addTarget(self, action: #selector(touchedCloseButton), for: .touchUpInside)
        wishButton.addTarget(self, action: #selector(touchedWishButton), for: .touchUpInside)
    }
    
    @objc func touchedCloseButton() {
        self.dismiss(animated: false)
    }
    
    @objc func touchedWishButton() {
        print("touched wish")
    }
    
    @objc func touchedShareButton() {
        print("touchedShareButton")
    }
    
    private func bindView() {
        self.useCase.roomDetail.bind { [weak self] data in
            self?.titleView.updateViews(title: data.title, averageOfStar: data.averageOfStar, numberOfReviews: data.numberOfReviews, address: "")
            self?.hostProfileView.updateViews(hostName: data.hostName, maxNumberOfPeople: data.maxNumberOfPeople, styleOfRoom: data.roomType, bedCount: data.bedCount, bathroomCount: data.bathroomCount)
            self?.reservateView.updateViews(priceForOneDay: data.priceForOneDay)
        }
        
        self.useCase.image.bind { [weak self] imageData in
            self?.imageView.image = UIImage(data: imageData)
            self?.hostProfileView.updateImageView(data: imageData)
        }
    }
    
    private let wishButton: RoundButton = {
        let button = RoundButton(imageName: "suit.heart")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let shareButton: RoundButton = {
        let button = RoundButton(imageName: "square.and.arrow.up")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let closeButton: RoundButton = {
        let button = RoundButton(imageName: "chevron.backward")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentInnerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleView = RoomDetailTitleView()
    private let hostProfileView = RoomDetailHostProfileView()
    private let reservateView = RoomDetailReservateView()
    private let descriptionView = RoomDetailDescriptionView()
    
    private func setupViews() {
        let bottomViewHeight: CGFloat = 80
        
        self.view.addSubview(contentScrollView)
        let safeAreaLayoutGuide = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            contentScrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -bottomViewHeight)
        ])
        
        contentScrollView.addSubview(contentInnerStackView)
        contentInnerStackView.addArrangedSubview(imageView)
        contentInnerStackView.addArrangedSubview(titleView)
        contentInnerStackView.addArrangedSubview(hostProfileView)
        contentInnerStackView.addArrangedSubview(descriptionView)
        NSLayoutConstraint.activate([
            contentInnerStackView.topAnchor.constraint(equalTo: contentScrollView.contentLayoutGuide.topAnchor),
            contentInnerStackView.leadingAnchor.constraint(equalTo: contentScrollView.contentLayoutGuide.leadingAnchor),
            contentInnerStackView.trailingAnchor.constraint(equalTo: contentScrollView.contentLayoutGuide.trailingAnchor),
            contentInnerStackView.bottomAnchor.constraint(equalTo: contentScrollView.contentLayoutGuide.bottomAnchor),
            
            imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.8)

        ])

        reservateView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(reservateView)
        reservateView.delegate = self
        NSLayoutConstraint.activate([
            reservateView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            reservateView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            reservateView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            reservateView.heightAnchor.constraint(equalToConstant: bottomViewHeight)
        ])
        
        self.view.addSubview(closeButton)
        self.view.addSubview(wishButton)
        self.view.addSubview(shareButton)
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            
            wishButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            wishButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            wishButton.widthAnchor.constraint(equalToConstant: 44),
            wishButton.heightAnchor.constraint(equalTo: wishButton.widthAnchor),
            
            shareButton.trailingAnchor.constraint(equalTo: wishButton.leadingAnchor, constant: -10),
            shareButton.topAnchor.constraint(equalTo: wishButton.topAnchor),
            shareButton.widthAnchor.constraint(equalToConstant: 44),
            shareButton.heightAnchor.constraint(equalTo: shareButton.widthAnchor)
        ])
    }
}

extension RoomDetailViewController: RoomDetailReservateViewDelegate {
    @objc func touchedRservationButton() {
        let reservationViewController = ReservationViewController(title: "")
        reservationViewController.modalPresentationStyle = .overCurrentContext
        present(ReservationViewController(title: ""), animated: true)
    }
}
