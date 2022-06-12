import Foundation
import Alamofire
import OSLog

protocol NetworkService {
    func request(endPoint: EndPoint, body: Data?, completion: @escaping (Result<Data, Error>) -> Void)
}

struct NetworkServiceManager: NetworkService {
    
    private let logger = Logger()
    private let converter: ObjectConvertible = CustomConverter()
    private var serializer: DataResponseSerializer {
        return .init(emptyResponseCodes: Set([201]))
    }
    
    private func headers(_ headers: [String: String]) -> HTTPHeaders {
        return HTTPHeaders(headers)
    }
    
    private func httpMethod(_ method: HttpMethod) -> HTTPMethod {
        return HTTPMethod(rawValue: method.description)
    }
    
    private func parameters(_ body: Data?) -> [String:Any]? {
        guard let body = body else { return nil}
        return converter.convertJsonToDictionary(from: body)
    }

    private func encoding(_ method: HttpMethod) -> ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.queryString
        case .post:
            return JSONEncoding.default
        }
    }
    
    func request(endPoint: EndPoint, body: Data?, completion: @escaping (Result<Data, Error>) -> Void) {

        AF.request(endPoint.url,
                   method: httpMethod(endPoint.method),
                   parameters: parameters(body),
                   encoding: encoding(endPoint.method),
                   headers: headers(endPoint.headers))
        .validate(statusCode: 200..<300)
        .response(responseSerializer: serializer) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(response.request)
                logger.error("\(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
