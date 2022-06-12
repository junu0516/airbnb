import UIKit

final class SearchFilterViewController: UIViewController {
    
    private var useCase: SearchFilterUseCase?
        
    private lazy var dummyView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var conditionSettingTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = searchFilterDataSource
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(SearchFilterTableViewCell.self, forCellReuseIdentifier: SearchFilterTableViewCell.identifier)
        return tableView
    }()
    
    typealias CELL = SearchFilterTableViewCell
    typealias DataSource = CustomTableDataSource
    private lazy var searchFilterDataSource: DataSource<CELL,FilterCategory> = DataSource(cellIdentifier: CELL.identifier,
                                                                                          items: FilterCategory.allCases) { cell, category in
        cell.updateLabelText(conditionTitle: "\(category)",
                             conditionValue: self.useCase?.getPositionValue(filterCategory: category) ?? "")
    }
    
    convenience init(useCase: SearchFilterUseCase) {
        self.init()
        self.useCase = useCase
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "숙소 찾기"
        setToolBar()
        setUpViews()
    }
    
    private func setToolBar() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let prevBarItem = UIBarButtonItem(title: "건너뛰기", style: .plain, target: self, action: nil)
        let nextBarItem = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(pushNextViewController))
        self.navigationController?.isToolbarHidden = false
        self.toolbarItems = [prevBarItem,flexibleSpace,nextBarItem]
        toolbarItems?.forEach { $0.tintColor = .black }
        
        prevBarItem.isEnabled = false
    }
    
    private func setUpViews() {
        self.view.addSubview(dummyView)
        self.view.addSubview(conditionSettingTableView)

        NSLayoutConstraint.activate([
            dummyView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            dummyView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            dummyView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            dummyView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.67),
            
            conditionSettingTableView.topAnchor.constraint(equalTo: dummyView.bottomAnchor),
            conditionSettingTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            conditionSettingTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            conditionSettingTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
        
    @objc private func pushNextViewController() {
        useCase?.getRoomList { [weak self] roomList in
            guard let searchCondition = self?.useCase?.searchCondition.value else { return }
            let usecase = RoomListUseCase(roomList: roomList, searchCondition: searchCondition)
            let viewController = RoomListViewController(useCase: usecase)
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension SearchFilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/CGFloat(FilterCategory.allCases.count)
    }
}
