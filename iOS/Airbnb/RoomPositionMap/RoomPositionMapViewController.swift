import UIKit
import GoogleMaps
import CoreLocation

final class RoomPositionMapViewController: UIViewController, CLLocationManagerDelegate {
    
    private let mapBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mapView: GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: 37.490864, longitude: 127.033406, zoom: 16)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    typealias Cell = RoomPositionMapCollectionViewCell
    typealias Item = RoomPositionInfo
    private let collectionViewDataSource = CustomCollectionViewDataSource<Cell, Item>(identifier: Cell.identifier,
                                                                                      items: []) { cell , item in
        cell.updateInfo(title: item.roomName,
                        price: item.price.toDecimalString() ?? "",
                        starCount: String(item.averageOfStar),
                        reviewCount: String(item.numberOfReviews))
    }
    private lazy var roomPositionInfoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: 15)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.register(RoomPositionMapCollectionViewCell.self,
                                forCellWithReuseIdentifier: RoomPositionMapCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self.collectionViewDataSource
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let locationManager: CLLocationManager = CLLocationManager()
    private var useCase: RoomPositionMapUseCase?
    
    convenience init(useCase: RoomPositionMapUseCase) {
        self.init()
        self.useCase = useCase
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.useCase?.initializeData()
        self.view.backgroundColor = .systemBackground
        
        setUpViews()
        bindView()
        configureMap()
    }
    
    private func bindView() {
        self.useCase?.roomPositionInfoList.bind { [weak self] _ in
            guard let items = self?.useCase?.roomPositionInfoList.value else { return }
            self?.collectionViewDataSource.updateNewItems(items: items)
            self?.roomPositionInfoCollectionView.reloadData()
            self?.addMarkers(roomPositionInfoList: items)
        }
    }
    
    private func setUpViews() {
        
        view.addSubview(mapBackgroundView)
        NSLayoutConstraint.activate([
            mapBackgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            mapBackgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapBackgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        mapBackgroundView.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: mapBackgroundView.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: mapBackgroundView.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: mapBackgroundView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: mapBackgroundView.trailingAnchor)
        ])
        
        mapView.addSubview(roomPositionInfoCollectionView)
        NSLayoutConstraint.activate([
            roomPositionInfoCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            roomPositionInfoCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            roomPositionInfoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            roomPositionInfoCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.17)
        ])
    }
    
    private func configureMap() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    private func addMarkers(roomPositionInfoList items: [RoomPositionInfo]) {
        for (index,item) in items.enumerated() {
            let latitude = Double(item.latitude) ?? 0.0
            let longitude = Double(item.longitude) ?? 0.0
            let coordinate = CLLocationCoordinate2D(latitude: latitude , longitude: longitude)

            addMarker(coordinate: coordinate,
                      price: item.price.toDecimalString() ?? "",
                      roomName: item.roomName)
            if index == 0 { moveToTargetPosition(coordinate: coordinate)}
        }
        
        func addMarker(coordinate: CLLocationCoordinate2D, price: String, roomName: String) {
            let marker = CustomMarker(title: price ,position: coordinate)
            marker.title = roomName
            marker.appearAnimation = GMSMarkerAnimation.pop
            
            marker.map = mapView
        }
    }
    
    private func moveToTargetPosition(coordinate: CLLocationCoordinate2D) {
        let camera = GMSCameraPosition(target: coordinate, zoom: 16)
        self.mapView.camera = camera
    }
}

extension RoomPositionMapViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width*0.9, height: collectionView.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let items = self.useCase?.roomPositionInfoList.value else { return }
        let itemCount = items.count
        let fullWidth = self.roomPositionInfoCollectionView.frame.width
        let contentOffsetX = targetContentOffset.pointee.x
        
        let targetItem = lround(Double(contentOffsetX/fullWidth))
        let targetIndex = targetItem % itemCount
        
        let coordinate = CLLocationCoordinate2D(latitude: items[targetIndex].latitude,
                                                longitude: items[targetIndex].longitude)
        self.moveToTargetPosition(coordinate: coordinate)
    }
}
