import Foundation
import OSLog

final class ReservationRepository {

    private let logger = Logger()
    private let networkHandler: NetworkHandlable
    private let jsonHandler: JsonHandlable
    
    init(networkHandler: NetworkHandlable, jsonHandler: JsonHandlable) {
        self.networkHandler = networkHandler
        self.jsonHandler = jsonHandler
    }
    
    func sendPostRequest<T: Encodable>(bodyObj: T, completion: @escaping () -> Void) {
        networkHandler.request(endPoint: .mockList,
                               method: .post,
                               contentType: .json,
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
