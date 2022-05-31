import Foundation
import OSLog

struct JsonHandler {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func convertJsonToObject<T: Decodable>(from data: Data, to targetType: T.Type) -> T? {
        return try? decoder.decode(T.self, from: data)
    }
    
    func convertObjectToJson<T: Encodable>(from object: T) -> Data? {
        return try? encoder.encode(object)
    }
}


struct RoomDetailRepository {
    private let networkHandler = NetworkHandler()
    private let jsonHandler = JsonHandler()
    private let logger = Logger()
    
    
    func fetch(roomId: UniqueID, completion: @escaping (RoomDetail) -> Void) {
        networkHandler.request(endPoint: .roomDetail(roomId: roomId), method: .get, contentType: .json, body: nil) { result in
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
    
    func fetchImage(_ completion: @escaping (Data) -> Void) {
        networkHandler.request(endPoint: .randomImage, method: .get, contentType: .image, body: nil) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                logger.error("\(error.localizedDescription)")
            }
        }
    }
}