import Foundation
import Alamofire
import OSLog

protocol NetworkHandlable {
    func request(endPoint: EndPoint, method: HttpMethod, contentType: ContentType, body: Data?, completion: @escaping (Result<Data, Error>) -> Void)
}

struct NetworkHandler: NetworkHandlable {
    
    private let logger = Logger()
    
    func request(endPoint: EndPoint, method: HttpMethod, contentType: ContentType, body: Data?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let urlComponents = URLComponents(string: endPoint.path) else {
            return
        }
        guard let request = try? URLRequest(url: urlComponents, method: HTTPMethod(rawValue: "\(method)"), headers: ["Content-Type":contentType.value]) else {
            return
        }
        AF.request(request).validate(statusCode: 200..<300)
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
