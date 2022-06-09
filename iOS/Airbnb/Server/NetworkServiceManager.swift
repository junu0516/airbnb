import Foundation
import Alamofire
import OSLog

protocol NetworkService {
    func request(endPoint: EndPoint, body: Data?, completion: @escaping (Result<Data, Error>) -> Void)
}

struct NetworkServiceManager: NetworkService {
    
    private let logger = Logger()
    private var serializer: DataResponseSerializer {
        return .init(emptyResponseCodes: Set([201]))
    }
    
    func request(endPoint: EndPoint, body: Data?, completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard var request = try? URLRequest(url: endPoint.url,
                                            method: HTTPMethod(rawValue: "\(endPoint.method)"),
                                            headers: HTTPHeaders(endPoint.headers)) else { return }
        request.httpBody = body
        
        AF.request(request)
        .validate(statusCode: 200..<300)
        .response(responseSerializer: serializer) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                logger.error("\(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
