import Foundation
import OSLog

final class ReservationRepository {

    private let logger = Logger()
    private let networkService: NetworkService
    private let converter: ObjectConvertible
    
    init(networkService: NetworkService, converter: ObjectConvertible) {
        self.networkService = networkService
        self.converter = converter
    }
    
    func sendPostRequest<T: Encodable>(bodyObj: T, completion: @escaping (Bool) -> Void) {
        
        guard let endPoint = EndPoint(path: .reservation, method: .post, headers: ["content-type":"\(ContentType.json)"]) else { return }
        networkService.request(endPoint: endPoint,
                               body: converter.convertObjectToJson(from: bodyObj)) { result in
            switch result {
            case .success(let data):
                completion(true)
            case .failure(let error):
                completion(false)
            }
        }
    }
}
