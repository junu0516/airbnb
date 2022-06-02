import UIKit


class RoomListViewController: UIViewController {

    private var useCase: RoomListUseCase?
    
    convenience init(useCase: RoomListUseCase) {
        self.init()
        self.useCase = useCase
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "숙소 찾기"
        self.view.backgroundColor = .white
        setupViews()
    }
    
    // MARK: - Views
    private let headerView = SearchResultRoomsHeaderView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.view.frame.size.width, height: 200)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchResultRoomCell.self, forCellWithReuseIdentifier: "SearchResultRoomCell")
        collectionView.backgroundColor = .orange
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var mapButton: UIButton = {
        let button = UIButton()
        button.setTitle("지도", for: .normal)
        button.backgroundColor = .brown
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(handler: { [weak self] _ in
            let repository = RoomPositionMapRepository(networkHandler: NetworkHandler(), jsonHandler: JsonHandler())
            let useCase = RoomPositionMapUseCase(roomPositionMapRepository: repository)
            self?.navigationController?.pushViewController(RoomPositionMapViewController(roomPositionMapUseCase: useCase), animated: true)
        }), for: .touchDown)
        return button
    }()
    
    // MARK: - private functions
    private func setupViews() {
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
extension RoomListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return useCase?.roomList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let room = useCase?.roomList[indexPath.row],
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultRoomCell", for: indexPath) as? SearchResultRoomCell else {
            return UICollectionViewCell()
        }
        cell.updateViews(title: room.roomName)
        return cell
    }
}

extension RoomListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedRoomId = useCase?.roomList[indexPath.row].roomId else {
            return
        }
        let detailUseCase = RoomDetailUseCase(roomId: selectedRoomId, repository: RoomDetailRepository())
        let viewController = RoomDetailViewController(useCase: detailUseCase)
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: false)
    }
}
