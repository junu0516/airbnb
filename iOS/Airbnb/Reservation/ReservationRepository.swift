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
    
    func sendPostRequest(requestBody: Data, completion: @escaping () -> Void) {
        networkHandler.request(endPoint: .mockList,
                               method: .post,
                               contentType: .json,
                               body: requestBody) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
