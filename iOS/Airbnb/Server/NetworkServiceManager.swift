import Foundation
import Alamofire
import OSLog

protocol NetworkService {
    func request(endPoint: EndPoint, body: Data?, completion: @escaping (Result<Data, Error>) -> Void)
}

struct NetworkServiceManager: NetworkService {
    
    private let logger = Logger()
    
    func request(endPoint: EndPoint, body: Data?, completion: @escaping (Result<Data, Error>) -> Void) {
        
        AF.request(endPoint.url,
                   method: HTTPMethod(rawValue: "\(endPoint.method)"),
                   parameters: body,
                   encoder: JSONParameterEncoder.prettyPrinted,
                   headers: HTTPHeaders(endPoint.headers))
        .validate(statusCode: 200..<300)
        .responseData { response in
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
