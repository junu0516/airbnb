import UIKit
import GoogleMaps

final class CustomMarker: GMSMarker {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        label.textAlignment = .center
        return label
    }()
    
    convenience init(title: String, position: CLLocationCoordinate2D) {
        self.init(position: position)
        self.addIconView()
        
        self.titleLabel.text = "₩\(title)"
        self.titleLabel.textColor = .black
        self.iconView?.addSubview(self.titleLabel)
    }
    
    private func addIconView() {
        let iconView = UIView(frame: CGRect(origin: .zero, size: titleLabel.bounds.size))
        iconView.backgroundColor = .white
        iconView.layer.cornerRadius = 25
        self.iconView = iconView
    }
}
