import Foundation

enum Path: CustomStringConvertible {
    case roomDetail(roomId: UniqueID)
    case list
    case image(url: String)
    case mockList
    case reservation
    
    static let origin: String = "http://13.125.155.123:8080"
    var description: String {
        switch self {
        case .roomDetail(let roomId):
            return "\(Path.origin)/airbnb/room/1"
        case .list:
            return "\(Path.origin)/airbnb/search/rooms"
        case .image(let url):
            return url
        case .mockList:
            return "https://68ba057f-eb57-4bad-be9b-d220ac63ca31.mock.pstmn.io/airbnb/search/rooms"
        case .reservation:
            return "\(Path.origin)/airbnb/room/make/reservation"
        }
    }
}

struct EndPoint {
    
    let url: URLComponents
    let method: HttpMethod
    private (set)var headers: [String:String] = [:]
    
    init?(path: Path, method: HttpMethod=HttpMethod.get, headers: [String:String]=["content-type":"applicatin/json"]) {
        guard let url = URLComponents(string: "\(path)") else { return nil }
        self.url = url
        self.method = method
        self.headers = headers
    }
}
