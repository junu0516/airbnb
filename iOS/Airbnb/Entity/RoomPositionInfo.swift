import Foundation
/*
 
 "roomId" : 1,
 "roomName" : "Spacious and Comfortable cozy house #4",
 "price" : 82953,
 "totalPrice" : 1493159,
 "thumbnailImage" : "www.naver.com",
 "averageOfStar": 4.98,
 "numberOfReviews": 50,
 "isWished" : false,
 "latitude" : "123.123.123.123",
 "logitude" : "123.123.123.123"
 
 */

struct RoomPositionInfoList: Codable {
    let numberOfRooms: Int
    var rooms: [RoomPositionInfo]
}

struct RoomPositionInfo: Codable {
    let roomId: Int
    let roomName: String
    let price: Int
    let totalPrice: Int
    let thumbnailImage: String
    let averageOfStar: Float
    let numberOfReviews: Int
    let wished: Bool
    var latitude: Double
    var longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case roomId
        case roomName
        case price
        case totalPrice
        case thumbnailImage
        case averageOfStar
        case numberOfReviews
        case wished
        case latitude
        case longitude
    }
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.roomId = try container.decode(Int.self, forKey: .roomId)
        self.roomName = try container.decode(String.self, forKey: .roomName)
        self.price = try container.decode(Int.self, forKey: .price)
        self.totalPrice = try container.decode(Int.self, forKey: .totalPrice)
        self.thumbnailImage = try container.decode(String.self, forKey: .thumbnailImage)
        self.averageOfStar = (try? container.decode(Float.self, forKey: .averageOfStar)) ?? 0.0
        self.numberOfReviews = (try? container.decode(Int.self, forKey: .numberOfReviews)) ?? 0
        self.wished = try container.decode(Bool.self, forKey: .wished)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
    }
}
