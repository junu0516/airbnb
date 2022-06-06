import UIKit

final class ReservationPriceView: UIView {

    private (set)lazy var priceTableView: UITableView = {
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
    typealias DataSource = SearchFilterTableViewDataSource
    let priceTableViewDataSource: DataSource<CELL,ReservationPrice> = DataSource(cellIdentifier: CELL.identifier,
                                                                               items: []) { cell, item in
        cell.updateLabelText(priceTitle: item.title.stringLiteral, priceValue: "\(item.value)")
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
        return tableView.frame.height/CGFloat(PriceCategory.allCases.count)
    }
}
