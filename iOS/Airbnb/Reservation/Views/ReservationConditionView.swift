import UIKit

final class ReservationConditionView: UIView {
    
    private let topLeftBackgroundView = UIView()
    private let topRightBackgroundView = UIView()
    private let bottomBackgroundView = UIView()
    
    private let checkInLabel = ConditionLabel(title: "체크인")
    private let checkOutLabel = ConditionLabel(title: "체크아웃")
    private let guestsCountLabel = ConditionLabel(title: "인원")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateValues(checkIn: String, checkOut: String, guestsCount: String) {
        checkInLabel.updateValueString(value: "5월 17일")
        checkOutLabel.updateValueString(value: "6월 4일")
        guestsCountLabel.updateValueString(value: "게스트 3명")
    }
    
    private func setUpViews() {
        
        self.addSubview(topLeftBackgroundView)
        self.addSubview(topRightBackgroundView)
        self.addSubview(bottomBackgroundView)
        topLeftBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        topRightBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        bottomBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topLeftBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            topLeftBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topLeftBackgroundView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            topLeftBackgroundView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            
            topRightBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            topRightBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topRightBackgroundView.widthAnchor.constraint(equalTo: topLeftBackgroundView.widthAnchor),
            topRightBackgroundView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            
            bottomBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomBackgroundView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
        ])
        
        topLeftBackgroundView.addSubview(checkInLabel)
        topRightBackgroundView.addSubview(checkOutLabel)
        bottomBackgroundView.addSubview(guestsCountLabel)
        NSLayoutConstraint.activate([
            checkInLabel.centerYAnchor.constraint(equalTo: topLeftBackgroundView.centerYAnchor),
            checkInLabel.heightAnchor.constraint(equalTo: topLeftBackgroundView.heightAnchor, multiplier: 0.6),
            checkInLabel.leadingAnchor.constraint(equalTo: topLeftBackgroundView.leadingAnchor, constant: 15),
            
            checkOutLabel.centerYAnchor.constraint(equalTo: topRightBackgroundView.centerYAnchor),
            checkOutLabel.heightAnchor.constraint(equalTo: topRightBackgroundView.heightAnchor, multiplier: 0.6),
            checkOutLabel.leadingAnchor.constraint(equalTo: topRightBackgroundView.leadingAnchor, constant: 15),
            
            guestsCountLabel.centerYAnchor.constraint(equalTo: bottomBackgroundView.centerYAnchor),
            guestsCountLabel.heightAnchor.constraint(equalTo: bottomBackgroundView.heightAnchor, multiplier: 0.6),
            guestsCountLabel.leadingAnchor.constraint(equalTo: bottomBackgroundView.leadingAnchor, constant: 15)
        ])
    }
}
