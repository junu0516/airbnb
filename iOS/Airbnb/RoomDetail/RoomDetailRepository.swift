import Foundation
import OSLog

struct RoomDetailRepository {
    
    private let networkHandler = NetworkServiceManager()
    private let jsonHandler = JsonHandler()
    private let logger = Logger()
    
    func fetch(roomId: UniqueID, completion: @escaping (RoomDetail) -> Void) {
        
        guard let endPoint = EndPoint(path: .roomDetail(roomId: roomId), method: .get, headers: ["Content-Type":"\(ContentType.json)"]) else { return }
        networkHandler.request(endPoint: endPoint, body: nil) { result in
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
    
    func fetchImage(imageUrl: String, _ completion: @escaping (Data) -> Void) {
        
        guard let endPoint = EndPoint(path: .image(url: imageUrl), method: .get, headers: ["Content-Type":"\(ContentType.image)"]) else { return }
        networkHandler.request(endPoint: endPoint, body: nil) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                logger.error("\(error.localizedDescription)")
            }
        }
    }
}
