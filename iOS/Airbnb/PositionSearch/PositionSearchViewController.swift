import UIKit

class PositionSearchViewController: UIViewController {
    
    private let useCase = PositionSearchUseCase(PositionSearchFactory(categoryCount: 9, dataCount: 9))
    
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
        useCase.isSearching.bind { [weak self] _ in
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
        return useCase.rowsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = useCase.titleText(in: indexPath.row)
        return cell
    }
}

extension PositionSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let positionTitle = self.useCase.titleText(in: indexPath.row)
        let useCase = SearchFilterUseCase(searchCondition: SearchCondition(positionTitle: positionTitle))
        self.navigationController?.pushViewController(SearchFilterViewController(useCase: useCase), animated: true)
    }
}

extension PositionSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        self.useCase.fetchPredctionList(searchText: searchText)
    }
}

extension PositionSearchViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        self.useCase.setIsSearching(false)
    }
}
