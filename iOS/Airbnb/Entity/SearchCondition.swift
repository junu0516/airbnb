import Foundation

struct SearchCondition {

    let positionTitle: String
    let checkInDate: DateComponents
    let checkOutDate : DateComponents
    let minPrice: Int
    let maxPrice: Int
    let guestCount: Int

    init(positionTitle: String="",
         checkInDate: DateComponents = .init(year: 2022, month:5, day: 9),
         checkOutDate: DateComponents = .init(year: 2022, month:5, day: 13),
         minPrice:Int = 0,
         maxPrice:Int = 100000,
         guestCount:Int = 3) {

        self.positionTitle = positionTitle
        self.checkInDate = checkInDate
        self.checkOutDate = checkOutDate
        self.minPrice = minPrice
        self.maxPrice = maxPrice
        self.guestCount = guestCount
    }
    
    func getMappedValue(filterCategory: FilterCategory) -> String {
        switch filterCategory {
        case .position:
            return self.positionTitle
        case .period:
            let checkInString = self.checkInDate.toFormattedString(format: "M월 d일")
            let checkOutString = self.checkOutDate.toFormattedString(format: "M월 d일")
            return "\(checkInString) ~ \(checkOutString)"
        case .price:
            let minPriceString = minPrice.toDecimalString() ?? "0"
            let maxPriceString = maxPrice.toDecimalString() ?? "0"
            return "₩\(minPriceString) ~ ₩\(maxPriceString)"
        case .guestCount:
            return "게스트 \(guestCount)명"
        }
    }
}

extension SearchCondition: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case location = "request[location]"
        case checkinDate = "request[checkinDate]"
        case checkoutDate = "request[checkoutDate]"
        case minPrice = "request[minPrice]"
        case maxPrice = "request[maxPrice]"
        case guestAmount = "request[guestAmount]"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.positionTitle, forKey: .location)
        try container.encode(self.checkInDate.toFormattedString(format: "yyyy-MM-dd"), forKey: .checkinDate)
        try container.encode(self.checkOutDate.toFormattedString(format: "yyyy-MM-dd"), forKey: .checkoutDate)
        try container.encode(self.minPrice, forKey: .minPrice)
        try container.encode(self.maxPrice, forKey: .maxPrice)
        try container.encode(self.guestCount, forKey: .guestAmount)
    }
}
