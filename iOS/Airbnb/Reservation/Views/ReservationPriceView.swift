import UIKit

enum ReservationPrices: String, CaseIterable {
    case originalPrice = "₩71,466 x 18박" //원가(1박당 가격 * 숙박일수)
    case weeklyDiscount = "4%주 단위 요금 할인" //주단위 할인
    case cleaningCost = "청소비" //청소 비용
    case serviceFee = "서비스 수수료" //서비스 수수료
    case accomodationFee = "숙박세와 수수료" //숙박세 및 수수료
}

final class ReservationPriceView: UIView {

    private lazy var priceTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = priceTableViewDataSource
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(ReservationPriceTableViewCell.self, forCellReuseIdentifier: ReservationPriceTableViewCell.identifier)
        return tableView
    }()
    
    typealias CELL = ReservationPriceTableViewCell
    typealias DataSource = ConditionSettingTableViewDataSource
    private let priceTableViewDataSource: DataSource<CELL,String> = DataSource(cellIdentifier: CELL.identifier,
                                                                                          items: ReservationPrices.allCases.map { $0.rawValue }) { cell, value in
        cell.updateLabelText(priceTitle: value, priceValue: "₩10,000")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        self.createLine(position: .bottom)
    }
    
    private func setUpViews() {
        self.addSubview(priceTableView)
        NSLayoutConstraint.activate([
            priceTableView.topAnchor.constraint(equalTo: self.topAnchor),
            priceTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            priceTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            priceTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension ReservationPriceView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/CGFloat(ReservationPrices.allCases.count)
    }
}
