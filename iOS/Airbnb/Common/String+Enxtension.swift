import Foundation

extension String {
    func toDate(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
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
        try container.encode(self.checkInDate.toDate(format: "yyyy-MM-dd"), forKey: .checkIn)
        try container.encode(self.checkOutDate.toDate(format: "yyyy-MM-dd"), forKey: .checkOut)
        try container.encode(self.cleaningPrice, forKey: .cleaningPrice)
        try container.encode(self.discountedPricePerWeek, forKey: .discountedPricePerWeek)
        try container.encode(self.fee, forKey: .fee)
        try container.encode(self.guestsCount, forKey: .guestAmount)
        try container.encode(1, forKey: .guestId)
        try container.encode(self.priceForOneDay, forKey: .priceForOneDay)
        try container.encode(self.tax, forKey: .tax)
        try container.encode(self.totalPrice, forKey: .totalPrice)
    }
}

