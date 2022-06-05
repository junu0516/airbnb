import UIKit

extension UIView {
    enum LinePosition {
        case top
        case bottom
    }
    
    func createLine(position: UIView.LinePosition, color: UIColor = .systemGray5) {
        let lineHeight: CGFloat = 1.0
        let point: CGPoint
        switch position {
        case .top:
            point = self.bounds.origin
        case .bottom:
            point = CGPoint(x: self.bounds.origin.x, y: self.bounds.origin.y + self.frame.height - lineHeight)
        }
        let lineFrame = CGRect(origin: point, size: CGSize(width: self.frame.width, height: lineHeight))
        let lineView = UIView(frame: lineFrame)
        lineView.backgroundColor = color
        self.addSubview(lineView)
    }
}
