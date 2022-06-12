import UIKit

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
        useCase.initializeData()
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
        // TODO: - 공유할 실제 url 로 바꾸기
        guard let objectToShare: URL = URL(string: "http://www.google.com") else {
            return
        }
        let shareObject: [AnyObject] = [objectToShare as AnyObject]
        let activityViewController = UIActivityViewController(activityItems: shareObject, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true)
    }
    
    private func bindView() {
        self.useCase.roomDetail.bind { [weak self] data in
            self?.titleView.updateViews(
                title: data.title,
                averageOfStar: data.averageOfStar,
                numberOfReviews: data.numberOfReviews,
                address: "")
            self?.hostProfileView.updateViews(
                hostName: data.hostName,
                maxNumberOfPeople: data.maxNumberOfPeople,
                styleOfRoom: data.roomType,
                bedCount: data.bedCount,
                bathroomCount: data.bathroomCount)
            self?.reservateView.updateViews(
                priceForOneDay: data.priceForOneDay,
                checkInDate: self?.useCase.searchCondition.checkInDate,
                checkOutDate: self?.useCase.searchCondition.checkOutDate)
            self?.carouselImageView.start(with: data.images.count)
        }
        
        self.useCase.didSuccessResponseImage = { [weak self] (imageData, index) in
            if imageData.isEmpty {
                return
            }
            self?.carouselImageView.loadImage(index: index, imageData: imageData)
        }
        
        self.useCase.profileImage.bind { [weak self] imageData in
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
    
    private let titleView = RoomDetailTitleView()
    private let hostProfileView = RoomDetailHostProfileView()
    private let reservateView = RoomDetailReservateView()
    private let descriptionView = RoomDetailDescriptionView()
    private let carouselImageView = RoomDetailCarouselImagesView()
    
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
        contentInnerStackView.addArrangedSubview(carouselImageView)
        contentInnerStackView.addArrangedSubview(titleView)
        contentInnerStackView.addArrangedSubview(hostProfileView)
        contentInnerStackView.addArrangedSubview(descriptionView)
        NSLayoutConstraint.activate([
            contentInnerStackView.topAnchor.constraint(equalTo: contentScrollView.contentLayoutGuide.topAnchor),
            contentInnerStackView.leadingAnchor.constraint(equalTo: contentScrollView.contentLayoutGuide.leadingAnchor),
            contentInnerStackView.trailingAnchor.constraint(equalTo: contentScrollView.contentLayoutGuide.trailingAnchor),
            contentInnerStackView.bottomAnchor.constraint(equalTo: contentScrollView.contentLayoutGuide.bottomAnchor),
            
            carouselImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            carouselImageView.heightAnchor.constraint(equalTo: carouselImageView.widthAnchor, multiplier: 0.8)

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
        let searchCondition = self.useCase.searchCondition
        let roomDetail = self.useCase.roomDetail.value
        
        let checkInDate = searchCondition.checkInDate
        let checkOutDate = searchCondition.checkOutDate
        let guestCount = searchCondition.guestCount
        let reservation = Reservation(checkInDate: checkInDate, checkOutDate: checkOutDate, guestsCount: guestCount, priceForOneDay: roomDetail.priceForOneDay)
        
        let repository = ReservationRepository(networkService: NetworkServiceManager(), jsonHandler: JsonHandler())
        let useCase = ReservationUseCase(reservationRepository: repository, reservation: reservation)
        let reservationViewController = ReservationViewController(reservationUseCase: useCase)
        reservationViewController.modalPresentationStyle = .popover
        present(reservationViewController, animated: true)
    }
}
