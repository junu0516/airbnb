import UIKit

final class HomeHeaderLabel: UIView {
    
    @CodableLayoutView(view: UILabel())
    private var mainTitle
    
    @CodableLayoutView(view: UILabel())
    private var subTitle
    
    @CodableLayoutView(view: UIButton())
    private var recommendationButton
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        
        self.addSubview(mainTitle)
        mainTitle.text = "슬기로운\n자연생활"
        mainTitle.numberOfLines = 2
        mainTitle.font = UIFont.systemFont(ofSize: 40)
        mainTitle.sizeToFit()
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            mainTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Margins.side),
            mainTitle.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2)
        ])
        
        self.addSubview(subTitle)
        subTitle.text = "에어비앤비가 엄선한\n위시리스트를 만나보세요"
        subTitle.numberOfLines = 2
        subTitle.font = UIFont.systemFont(ofSize: 20)
        subTitle.textColor = .systemGray
        NSLayoutConstraint.activate([
            subTitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 18),
            subTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Margins.side)
        ])
        
        self.addSubview(recommendationButton)
        recommendationButton.backgroundColor = .black
        recommendationButton.setTitle("여행 아이디어 얻기", for: .normal)
        recommendationButton.isEnabled = false
        recommendationButton.setTitleColor(.white, for: .normal)
        recommendationButton.titleLabel?.textAlignment = .center
        recommendationButton.clipsToBounds = true
        recommendationButton.layer.cornerRadius = 10
        recommendationButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        NSLayoutConstraint.activate([
            recommendationButton.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 18),
            recommendationButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Margins.side),
            recommendationButton.widthAnchor.constraint(equalTo: subTitle.widthAnchor, multiplier: 0.8)
        ])
    }
}
