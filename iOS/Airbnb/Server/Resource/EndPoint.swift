import Foundation

enum EndPoint {
    case roomDetail(roomId: UniqueID)
    case list
    case image(url: String)
    case mockList
    
    static let origin: String = "http://13.125.155.123:8080"
    var path: String {
        switch self {
        case .roomDetail(let roomId):
            return "\(EndPoint.origin)/airbnb/room/1"
        case .list:
            return "\(EndPoint.origin)/airbnb/search/rooms"
        case .image(let url):
            return url
        case .mockList:
            return "https://68ba057f-eb57-4bad-be9b-d220ac63ca31.mock.pstmn.io/airbnb/search/rooms"
        }
    }
}
