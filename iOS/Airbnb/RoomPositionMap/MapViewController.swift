import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    private var locationManager: CLLocationManager = CLLocationManager()
    
    private let mapBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mapView: GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: 37.490864, longitude: 127.033406, zoom: 16)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private var markers: [GMSMarker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        mapView.delegate = self
        addViews()
        setLayout()
        configureMap()
    }
    
    private func addViews() {
        view.addSubview(mapBackgroundView)
        mapBackgroundView.addSubview(mapView)
    }
    
    private func setLayout() {
        
        NSLayoutConstraint.activate([
            mapBackgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            mapBackgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapBackgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mapView.topAnchor.constraint(equalTo: mapBackgroundView.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: mapBackgroundView.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: mapBackgroundView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: mapBackgroundView.trailingAnchor)
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

extension MapViewController: GMSMapViewDelegate {
    
    //터치한 지점의 좌표값 출력
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("탭한 위치 표시\n위도:\(coordinate.latitude)\n경도:\(coordinate.longitude)")
    }
    
    //사용자 동작에 따른 위치값 변화 감지
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let topLeft = mapView.projection.visibleRegion().farLeft
        let topRight = mapView.projection.visibleRegion().farRight
        let bottomleft = mapView.projection.visibleRegion().nearLeft
        let bottomRight = mapView.projection.visibleRegion().nearRight
    }
}
