import Foundation

struct Reservation {
    
    let roomId: Int = 1
    let checkInDate: DateComponents
    let checkOutDate : DateComponents
    let guestsCount: Int
    let priceForOneDay: Int
    let priceForAllDates: Int

    @PriceCalculator(category: PriceCategory.cleaningCost)
    var cleaningPrice: Int
  
    @PriceCalculator(category: PriceCategory.weeklyDiscount)
    var discountedPricePerWeek: Int
    
    @PriceCalculator(category: PriceCategory.serviceFee)
    var fee: Int
    
    @PriceCalculator(category: PriceCategory.accomodationFee)
    var tax: Int
    
    var totalPrice: Int {
        return priceForAllDates+discountedPricePerWeek+cleaningPrice+fee+tax
    }
    
    init(checkInDate: DateComponents, checkOutDate: DateComponents, guestsCount: Int, priceForOneDay: Int) {
        self.checkInDate = checkInDate
        self.checkOutDate = checkOutDate
        self.guestsCount = guestsCount
        self.priceForOneDay = priceForOneDay
        
        let intervals = checkOutDate.getDateInterval(from: checkInDate)
        let priceForAllDates = priceForOneDay*intervals
        
        self.priceForAllDates = priceForAllDates
        self.cleaningPrice = priceForAllDates
        self.fee = priceForAllDates
        self.tax = priceForAllDates
        self.discountedPricePerWeek = intervals>=7 ?  priceForAllDates : 0
    }
}

extension Reservation: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case checkIn
        case checkOut
        case cleaningPrice
        case discountedPricePerWeek
        case fee
        case guestAmount
        case guestId
        case priceForOneDay
        case roomId
        case tax
        case totalPrice
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.checkInDate.toFormattedString(format: "yyyy-MM-dd"), forKey: .checkIn)
        try container.encode(self.checkOutDate.toFormattedString(format: "yyyy-MM-dd"), forKey: .checkOut)
        try container.encode(self.cleaningPrice, forKey: .cleaningPrice)
        try container.encode(self.discountedPricePerWeek, forKey: .discountedPricePerWeek)
        try container.encode(self.fee, forKey: .fee)
        try container.encode(self.guestsCount, forKey: .guestAmount)
        try container.encode(1, forKey: .guestId)
        try container.encode(self.priceForOneDay, forKey: .priceForOneDay)
        try container.encode(self.tax, forKey: .tax)
        try container.encode(self.totalPrice, forKey: .totalPrice)
        try container.encode(self.roomId, forKey: .roomId)
    }
}

