import UIKit

final class ReservationViewController: UIViewController {
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "₩70,358 / 박"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var reservationButton: UIButton = {
        let button = UIButton()
        button.setTitle("예약하기", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemIndigo
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.viewModel?.sendReservationRequest()
        }), for: .touchDown)
        return button
    }()
    
    private let conditionView = ReservationConditionView()
    private let noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "예약 확정 전에는 요금이 청구되지 않습니다."
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pricesView: ReservationPriceView = {
        let view = ReservationPriceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "합계"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let totalPriceValueLabel: UILabel = {
        let label = UILabel()
        label.text = "₩50,000"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private var viewModel: ReservationViewModel?
    
    convenience init(reservationViewModel viewModel: ReservationViewModel) {
        self.init()
        self.viewModel = viewModel
    }
        
    override func viewDidLoad() {
        self.view.backgroundColor = .systemBackground
        setUpViews()
        bindView()
    }
    
    private func bindView() {
        self.viewModel?.reservation.bind { [weak self] reservation in
            self?.conditionView.updateValues(checkIn: reservation.checkInDate.toFormattedString(format: "M월 d일"),
                                             checkOut: reservation.checkOutDate.toFormattedString(format: "M월 d일"),
                                             guestsCount: "게스트 \(reservation.guestsCount)명")
            self?.viewModel?.reservationPrices.value = self?.viewModel?.generateReservationPrices() ?? []
            self?.totalPriceValueLabel.text = "₩\(reservation.totalPrice.toDecimalString() ?? "")"
        }
        
        self.viewModel?.reservationPrices.bind { [weak self] items in
            self?.pricesView.priceTableViewDataSource.updateNewItems(items: items)
            self?.pricesView.priceTableView.reloadData()
        }
    }
    
    private func setUpViews() {
        
        self.view.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
            priceLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            priceLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25)
        ])
        
        self.view.addSubview(conditionView)
        conditionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            conditionView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            conditionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            conditionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            conditionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        self.view.addSubview(reservationButton)
        reservationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reservationButton.topAnchor.constraint(equalTo: conditionView.bottomAnchor, constant: 15),
            reservationButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            reservationButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            reservationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.view.addSubview(noticeLabel)
        noticeLabel.translatesAutoresizingMaskIntoConstraints = false
        noticeLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            noticeLabel.topAnchor.constraint(equalTo: reservationButton.bottomAnchor, constant: 15),
            noticeLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            noticeLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25)
        ])
        
        self.view.addSubview(pricesView)
        pricesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pricesView.topAnchor.constraint(equalTo: noticeLabel.bottomAnchor, constant: 20),
            pricesView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            pricesView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            pricesView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.35)
        ])
        
        self.view.addSubview(totalPriceLabel)
        self.view.addSubview(totalPriceValueLabel)
        NSLayoutConstraint.activate([
            totalPriceLabel.topAnchor.constraint(equalTo: pricesView.bottomAnchor, constant: 20),
            totalPriceLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            totalPriceValueLabel.topAnchor.constraint(equalTo: pricesView.bottomAnchor, constant: 20),
            totalPriceValueLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25)
        ])
    }
}
