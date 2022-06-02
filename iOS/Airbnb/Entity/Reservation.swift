import Foundation

/*
{
  "checkIn": "2022-06-06",
  "checkOut": "2022-06-06",
  "cleaningPrice": 0,
  "discountedPricePerWeek": 0,
  "fee": 0,
  "guestAmount": 0,
  "guestId": 1,
  "priceForOneDay": 0,
  "roomId": 0,
  "tax": 0,
  "totalPrice": 0
}
*/

struct Reservation {

    let roomId: Int = 1
    let checkInDate: DateComponents
    let checkOutDate : DateComponents
    let guestsCount: Int
    let priceForOneDay: Int

    //1박당 가격 * 숙박일수
    var priceForWholeDates: Int {
        return priceForOneDay*(checkOutDate.getDateInterval(from: checkInDate))
    }
    //총 금액의 2%
    var cleaningPrice: Int {
        return Int(Double(priceForWholeDates)*0.02)
    }
    //4% 주 단위 요금 할인(7일 이상일 경우 적용)
    var discountedPricePerWeek: Int{
        let interval = checkOutDate.getDateInterval(from: checkInDate)
        return interval >= 7 ? -Int(Double(priceForWholeDates)*0.04) : 0
    }
    //총 금액의 7%
    var fee: Int {
        return Int(Double(priceForWholeDates)*0.07)
    }
    //수수료의 10%
    var tax: Int {
        return Int(Double(fee)*0.1)
    }
    var totalPrice: Int {
        return priceForWholeDates+discountedPricePerWeek+cleaningPrice+fee+tax
    }
    
    init(checkInDate: DateComponents, checkOutDate: DateComponents, guestsCount: Int, priceForOneDay: Int) {
        self.checkInDate = checkInDate
        self.checkOutDate = checkOutDate
        self.guestsCount = guestsCount
        self.priceForOneDay = priceForOneDay
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
