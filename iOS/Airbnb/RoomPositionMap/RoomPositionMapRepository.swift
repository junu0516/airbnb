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
        guard let endPoint = EndPoint(path: Path.list, method: .get, headers: ["Content-Type":"\(ContentType.json)"]) else { return }
        let body = converter.convertObjectToJson(from: SearchCondition())
        
        networkService.request(endPoint: endPoint,
                               body: body) { result in
            switch result {
            case .success(let data):
                guard let decodedData = converter.convertJsonToObject(from: data, to: RoomPositionInfoList.self) else {
                    print("JSON Parsing Error")
                    return
                }
                completion(decodedData)

            case .failure(let error):
                logger.error("\(error.localizedDescription)")
            }
        }
    }
}
