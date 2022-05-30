import Foundation
import OSLog

struct JsonHandler {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func convertJsonToObject<T: Decodable>(from data: Data, to targetType: T.Type) -> T? {
        return try? decoder.decode(T.self, from: data)
    }
}


struct AccomodationDetailRepository {
    private let networkHandler = NetworkHandler()
    private let jsonHandler = JsonHandler()
    private let logger = Logger()
    
    
    func fetch(roomId: UniqueID, completion: @escaping (RoomDetail) -> Void) {
        NetworkHandler().request(endPoint: .accomodationDetail(roomId: roomId), method: .get, contentType: .json, body: nil) { result in
            switch result {
            case .success(let data):
                guard let decodedData = jsonHandler.convertJsonToObject(from: data, to: RoomDetail.self) else {
                    return
                }
                completion(decodedData)
                
            case .failure(let error):
                logger.error("\(error.localizedDescription)")
            }
        }
    }
}
