import Foundation

struct RoomSearchUseCase {
    
    private var searchCondition = Observable<SearchCondition>(SearchCondition())
    
    init(searchCondition: SearchCondition) {
        self.searchCondition.value = searchCondition
    }
    
    func getRoomList(_ completion: @escaping ([Room]) -> Void) {
        // TODO: repository 를 통해 실서버의 데이터 가져오기
        completion(RoomSearchResultFactory().roomList)
    }
}

struct SearchCondition {
    private let positionTitle: String
    private let longitude: Double
    private let latitude: Double
    
    init() {
        self.positionTitle = ""
        self.longitude = 0
        self.latitude = 0
    }
    
    init(positionTitle: String, logntitude: Double, latitude: Double) {
        self.positionTitle = positionTitle
        self.longitude = logntitude
        self.latitude = latitude
    }
}

struct RoomSearchResultFactory {
    
    private (set)var roomList: [Room] = [
        .init(roomId: 1, roomName: "Spacious and Comfortable cozy house #4", thumbnailImage: "https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/1-%EC%A7%84%EB%B6%80%EB%A9%B4-%EC%9D%80%EC%A7%801.PNG", pricePerDay: 32000, isWished: true, averageOfStar: 3.8, numberOfReviews: 125),
        .init(roomId: 2, roomName: "cozy house", thumbnailImage: "https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/1-%EC%A7%84%EB%B6%80%EB%A9%B4-%EC%9D%80%EC%A7%802.PNG", pricePerDay: 47000, isWished: false, averageOfStar: 5.0, numberOfReviews: 5),
        .init(roomId: 3, roomName: "sunset house", thumbnailImage: "https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/1-%EC%A7%84%EB%B6%80%EB%A9%B4-%EC%9D%80%EC%A7%803.PNG", pricePerDay: 36600, isWished: false, averageOfStar: 2.3, numberOfReviews: 10),
        .init(roomId: 4, roomName: "Green View", thumbnailImage: "https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/1-%EC%A7%84%EB%B6%80%EB%A9%B4-%EC%9D%80%EC%A7%804.PNG", pricePerDay: 41000, isWished: false, averageOfStar: 4.1, numberOfReviews:62),
    ]
}


// MARK: - Entity
struct Room {
    let roomId: UniqueID
    let roomName: String
    let thumbnailImage: String //url
    let pricePerDay: Int
    let isWished: Bool
    let averageOfStar: Float
    let numberOfReviews: Int
}
