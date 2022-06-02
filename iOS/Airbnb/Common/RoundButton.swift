import UIKit

class RoundButton: UIButton {
    
    convenience init(imageName: String) {
        self.init(frame: .zero)
        let font = UIFont.boldSystemFont(ofSize: 22)
        let configuration = UIImage.SymbolConfiguration(font: font)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        self.setImage(image, for: .normal)
        self.backgroundColor = .white
        self.tintColor = .darkGray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = rect.width/2
        clipsToBounds = true
    }
}
