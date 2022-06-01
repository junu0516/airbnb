import Foundation
import OSLog

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
