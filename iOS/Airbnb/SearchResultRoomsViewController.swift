import UIKit


class SearchResultRoomsViewController: UIViewController {

    private let dummy = ["cozy house", "private room", "party room"]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.view.frame.size.width, height: 200)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(SearchResultRoomCell.self, forCellWithReuseIdentifier: "SearchResultRoomCell")
        cv.backgroundColor = .orange
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        return cv
    }()
    
    private lazy var mapButton: UIButton = {
        let button = UIButton()
        button.setTitle("지도", for: .normal)
        button.backgroundColor = .brown
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let headerView = SearchResultRoomsHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "숙소 찾기"
        self.view.backgroundColor = .white
        
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        view.addSubview(mapButton)
        NSLayoutConstraint.activate([
            mapButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            mapButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension SearchResultRoomsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultRoomCell", for: indexPath) as!SearchResultRoomCell
        return cell
    }
}

// MARK: - SearchResultRoomCell
class SearchResultRoomCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        self.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "aaaa"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
        return label
    }()
    
    private func setupViews() {
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}


// MARK: - SearchResultRoomsHeaderView
class SearchResultRoomsHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [detailDescriptionLabel, roomCountLabel])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            self.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
    }
    
    private let detailDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "5월 25일 ~ 5월 28일 ・ 게스트 3명"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let roomCountLabel: UILabel = {
        let label = UILabel()
        label.text = "300개 이상의 숙소"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
