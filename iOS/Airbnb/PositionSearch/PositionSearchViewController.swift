import UIKit

class PositionSearchViewController: UIViewController {
    
    private let model = PositionSearchUseCase(PositionSearchFactory(categoryCount: 9, dataCount: 9))
    
    private lazy var searchContoller: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "어디로 여행가세요?"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = tableView
        setNavigationBar()
        bindModel()
    }
    
    private func bindModel() {
        model.isSearching.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "숙소 찾기"
        self.navigationItem.searchController = searchContoller
    }
}


extension PositionSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.rowsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = model.titleText(in: indexPath.row)
        return cell
    }
}

extension PositionSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.model.searchPositionInfo(index: indexPath.row) { searchCondition in
            let model = ConditionSettingUseCase(searchCondition: searchCondition)
            self.navigationController?.pushViewController(ConditionSettingViewController(conditionSettingModel: model), animated: true)
            
        }
    }
}

extension PositionSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        self.model.fetchPredctionList(searchText: searchText)
    }
}

extension PositionSearchViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        model.setIsSearching(false)
    }
}