import UIKit

class PositionSearchViewController: UIViewController {

    private let model = PositionSearchModel()
    
    private lazy var searchContoller: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "어디로 여행가세요?"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
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
        self.navigationController?.pushViewController(ConditionSettingViewController(), animated: true)
    }
}

extension PositionSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        model.updateSearchResults(searchText: searchController.searchBar.text)
    }
}

extension PositionSearchViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        model.setIsSearching(false)
    }
}
