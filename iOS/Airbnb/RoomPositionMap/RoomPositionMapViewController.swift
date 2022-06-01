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
    
    private lazy var roomPositionInfoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: 5)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.register(RoomPositionMapCollectionViewCell.self,
                                forCellWithReuseIdentifier: RoomPositionMapCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let locationManager: CLLocationManager = CLLocationManager()
    private var markers: [GMSMarker] = []
    private var roomPositionMapUseCase: RoomPositionMapUseCase?
    
    convenience init(roomPositionMapUseCase useCase: RoomPositionMapUseCase) {
        self.init()
        self.roomPositionMapUseCase = useCase
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.roomPositionMapUseCase?.initialize()
        self.view.backgroundColor = .systemBackground
        mapView.delegate = self
        addComponentViews()
        setComponentLayout()
        configureMap()
        bindView()
    }
    
    private func bindView() {
        self.roomPositionMapUseCase?.roomPositionInfoList.bind { [weak self] _ in
            self?.roomPositionInfoCollectionView.reloadData()
        }
    }
    
    private func addComponentViews() {
        view.addSubview(mapBackgroundView)
        mapBackgroundView.addSubview(mapView)
        mapView.addSubview(roomPositionInfoCollectionView)
    }
    
    private func setComponentLayout() {
        NSLayoutConstraint.activate([
            mapBackgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            mapBackgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapBackgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mapView.topAnchor.constraint(equalTo: mapBackgroundView.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: mapBackgroundView.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: mapBackgroundView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: mapBackgroundView.trailingAnchor),
            
            roomPositionInfoCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            roomPositionInfoCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            roomPositionInfoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            roomPositionInfoCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
    }
    
    private func configureMap() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        addMarker(coordinate: mapView.camera.target, title: "코드스쿼드", snippet: "코드스쿼드")
    }
    
    //위치값 입력받아서, 해당 위치에 마커 추가
    private func addMarker(coordinate: CLLocationCoordinate2D, title: String, snippet: String) {
        let marker = GMSMarker()
        marker.position = coordinate
        marker.title = title
        marker.snippet = snippet
        marker.map = mapView
        markers.append(marker)
    }
}

extension RoomPositionMapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("탭한 위치 표시\n위도:\(coordinate.latitude)\n경도:\(coordinate.longitude)")
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let topLeft = mapView.projection.visibleRegion().farLeft
        let topRight = mapView.projection.visibleRegion().farRight
        let bottomleft = mapView.projection.visibleRegion().nearLeft
        let bottomRight = mapView.projection.visibleRegion().nearRight

    }
}

extension RoomPositionMapViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roomPositionMapUseCase?.roomPositionInfoList.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoomPositionMapCollectionViewCell.identifier, for: indexPath) as? RoomPositionMapCollectionViewCell,
              let roomPositionInfo = self.roomPositionMapUseCase?.roomPositionInfoList.value[indexPath.row] else { return UICollectionViewCell() }
        cell.updateInfo(title: roomPositionInfo.roomName,
                        price: String(roomPositionInfo.price),
                        starCount: String(roomPositionInfo.averageOfStar),
                        reviewCount: String(roomPositionInfo.numberOfReviews))
        return cell
    }
    
}

extension RoomPositionMapViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width*0.9, height: collectionView.frame.height)
    }
}
