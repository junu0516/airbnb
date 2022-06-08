import Foundation
import OSLog

final class ReservationRepository {

    private let logger = Logger()
    private let networkHandler: NetworkService
    private let jsonHandler: JsonHandlable
    
    init(networkHandler: NetworkService, jsonHandler: JsonHandlable) {
        self.networkHandler = networkHandler
        self.jsonHandler = jsonHandler
    }
    
    func sendPostRequest<T: Encodable>(bodyObj: T, completion: @escaping () -> Void) {
        
        guard let endPoint = EndPoint(path: .reservation, method: .post, headers: ["Content-Type": "\(ContentType.json)"]) else { return }
        networkHandler.request(endPoint: endPoint,
                               body: jsonHandler.convertObjectToJson(from: bodyObj)) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
