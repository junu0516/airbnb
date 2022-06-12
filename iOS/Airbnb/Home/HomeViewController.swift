import UIKit

class HomeViewController: UIViewController {
    
    private lazy var searchBar: UISearchBar = {
        let searchBar:UISearchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "어디로 여행가세요?"
        return searchBar
    }()
    
    @CodableLayoutView(view: UIImageView())
    private var mainImageView: UIImageView
    
    @CodableLayoutView(view: HomeHeaderLabel())
    private var homeHeaderLabel: HomeHeaderLabel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationItem.titleView = searchBar
        
        setUpViews()
    }
    
    private func setUpViews() {
        
        self.mainImageView.image = UIImage(named: "image_background")
        self.view.addSubview(mainImageView)
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            mainImageView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.65)
        ])
        
        self.mainImageView.addSubview(homeHeaderLabel)
        NSLayoutConstraint.activate([
            homeHeaderLabel.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: Margins.top)
        ])
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.navigationController?.pushViewController(PositionSearchViewController(), animated: false)
        return false
    }
}

