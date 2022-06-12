import Foundation

typealias UniqueID = Int

//{
//  "roomId": 1,
//  "images": [
//    "https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/1-%EC%A7%84%EB%B6%80%EB%A9%B4-%EC%9D%80%EC%A7%801.PNG",
//    "https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/1-%EC%A7%84%EB%B6%80%EB%A9%B4-%EC%9D%80%EC%A7%802.PNG",
//    "https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/1-%EC%A7%84%EB%B6%80%EB%A9%B4-%EC%9D%80%EC%A7%803.PNG",
//    "https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/1-%EC%A7%84%EB%B6%80%EB%A9%B4-%EC%9D%80%EC%A7%804.PNG"
//  ],
//  "title": "Euji님이 호스팅하는 집 전체",
//  "averageOfStar": 4.8,
//  "numberOfReviews": 127,
//  "address": {},
//  "hostName": "zzangmin",
//  "profileOfHost": "https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/%ED%98%B8%EC%8A%A4%ED%8A%B8+%EC%9D%B4%EB%AF%B8%EC%A7%80/%EC%A7%B1%EA%B5%AC-%ED%94%84%EB%A1%9C%ED%95%84.PNG",
//  "maxNumberOfPeople": 6,
//  "roomType": "RESIDENCE",
//  "bedCount": 3,
//  "bathroomCount": 2,
//  "description": "계곡 옆 시냇물 소리와 함께 조용한곳에서 프라이빗하게 힐링하다 가실수 잇는 숙소입니다!",
//  "priceForOneDay": 340000,
//  "wished": true,
//  "isWished": true
//}

struct RoomDetail: Codable {
    let roomId: UniqueID
    let images: [String] // url
    let isWished: Bool
    let wished: Bool
    let title: String
    let averageOfStar: Float
    let numberOfReviews: Int
    let address: String
    let hostName: String
    let profileOfHost: String // url
    let maxNumberOfPeople: Int
    let roomType: String // enum
    let bedCount: Int
    let bathroomCount: Int
    let roomDescription: String // room
    let priceForOneDay: Int
    
    init(roomId: UniqueID = 0,
         images: [String] = [],
         isWished: Bool = false,
         wished: Bool = false,
         title: String = "",
         averageOfStar: Float = 0.0,
         numberOfReviews: Int = 0,
         address: String = "",
         hostName: String = "",
         profileOfHost: String = "",
         maxNumberOfPeople:Int = 0,
         roomType: String = "원룸",
         bedCount: Int = 0,
         bathroomCount: Int = 0,
         roomDescription: String = "",
         priceForOneDay: Int = 0) {
        
        self.roomId = roomId
        self.images = images
        self.isWished = isWished
        self.wished = wished
        self.title = title
        self.averageOfStar = averageOfStar
        self.numberOfReviews = numberOfReviews
        self.address = address
        self.hostName = hostName
        self.profileOfHost = profileOfHost
        self.maxNumberOfPeople = maxNumberOfPeople
        self.roomType = roomType
        self.bedCount = bedCount
        self.bathroomCount = bathroomCount
        self.roomDescription = roomDescription
        self.priceForOneDay = priceForOneDay
    }
        
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.roomDescription = try container.decode(String.self, forKey: .roomDescription)
        self.roomId = try container.decode(UniqueID.self, forKey: .roomId)
        self.images = try container.decode([String].self, forKey: .images)
        self.isWished = try container.decode(Bool.self, forKey: .isWished)
        self.wished = try container.decode(Bool.self, forKey: .wished)
        self.title = try container.decode(String.self, forKey: .title)
        self.averageOfStar = try container.decode(Float.self, forKey: .averageOfStar)
        self.numberOfReviews = try container.decode(Int.self, forKey: .numberOfReviews)
                self.address = (try? container.decode(String.self, forKey: .address)) ?? ""
        self.hostName = try container.decode(String.self, forKey: .hostName)
        self.profileOfHost = try container.decode(String.self, forKey: .profileOfHost)
        self.maxNumberOfPeople = try container.decode(Int.self, forKey: .maxNumberOfPeople)
        self.roomType = try container.decode(String.self, forKey: .roomType)
        self.bedCount = try container.decode(Int.self, forKey: .bedCount)
        self.bathroomCount = try container.decode(Int.self, forKey: .bathroomCount)
        self.priceForOneDay = try container.decode(Int.self, forKey: .priceForOneDay)
    }
    
    enum CodingKeys: String, CodingKey {
        case roomDescription = "description"
        case roomId
        case images
        case isWished
        case wished
        case title
        case averageOfStar
        case numberOfReviews
        case address
        case hostName
        case profileOfHost
        case maxNumberOfPeople
        case roomType
        case bedCount
        case bathroomCount
        case priceForOneDay
    }
}
