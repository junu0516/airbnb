import Foundation
import OSLog

struct RoomPositionMapRepository {
    
    private let logger = Logger()
    private let networkHandler: NetworkHandlable
    private let jsonHandler: JsonHandlable
    
    init(networkHandler: NetworkHandlable, jsonHandler: JsonHandlable) {
        self.networkHandler = networkHandler
        self.jsonHandler = jsonHandler
    }
    
    func fetch(completion: @escaping (RoomPositionInfoList) -> Void) {
        networkHandler.request(endPoint: .list,
                               method: .get,
                               contentType: .json,
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
