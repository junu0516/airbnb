import Foundation

enum PriceCategory: CaseIterable{
    case originalPrice(price: String="", dates:String="")
    case weeklyDiscount
    case cleaningCost
    case serviceFee
    case accomodationFee
    
    var stringLiteral: String {
        switch self {
        case .originalPrice(let price, let dates):
            return "₩\(price) x \(dates)박"
        case .weeklyDiscount:
            return "4% 주 단위 요금 할인"
        case .cleaningCost:
            return "청소비"
        case .serviceFee:
            return "서비스 수수료"
        case .accomodationFee:
            return "숙박세와 수수료"
        }
    }
    
    static var allCases: [PriceCategory] {
        return [
            .originalPrice(price: "", dates: ""),
            .weeklyDiscount,
            .cleaningCost,
            .serviceFee,
            .accomodationFee
        ]
    }
}

struct ReservationPrice {
    
    let title: PriceCategory
    let value: Int
}
