import Foundation

@propertyWrapper
struct PriceCalculator {
    
    private let category: PriceCategory
    private var price: Int
    
    var wrappedValue: Int {
        get {
            return calculate()
        }
        set {
            self.price = newValue
        }
    }
    
    init(price: Int=0, category: PriceCategory) {
        self.price = price
        self.category = category
    }
}

extension PriceCalculator {
    
    private func calculate() -> Int {
        switch category {
        case .originalPrice(_,_):
            return price
        case .weeklyDiscount:
            return -Int(Double(price)*0.04)
        case .cleaningCost:
            return Int(Double(price)*0.02)
        case .serviceFee:
            return Int(Double(price)*0.07)
        case .accomodationFee:
            let serviceFee = Int(Double(price)*0.07)
            return Int(Double(serviceFee)*0.1)
        }
    }
}
