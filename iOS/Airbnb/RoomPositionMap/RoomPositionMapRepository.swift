import Foundation
import OSLog

struct RoomPositionMapRepository {
    
    private let logger = Logger()
    private let networkService: NetworkService
    private let converter: ObjectConvertible
    
    init(networkService: NetworkService, converter: ObjectConvertible) {
        self.networkService = networkService
        self.converter = converter
    }
    
    func fetch(completion: @escaping (RoomPositionInfoList) -> Void) {
        
        if let endPoint = EndPoint(path: Path.mockList, method: .get, headers: ["Content-Type":"\(ContentType.json)"]) {
            networkService.request(endPoint: endPoint,
                                   body: nil) { result in
                switch result {
                case .success(let data):
                    if let decodedData = jsonHandler.convertJsonToObject(from: data, to: RoomPositionInfoList.self) {
                        completion(decodedData)
                    }
                case .failure(let error):
                    logger.error("\(error.localizedDescription)")
                }
            }
        }
    }
}
