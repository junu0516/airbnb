import Foundation

struct MockNetworkHandler: NetworkHandlable {
    
    var expectSucceed: Bool = true
    
    func request(endPoint: EndPoint,
                 method: HttpMethod,
                 contentType: ContentType,
                 body: Data?,
                 completion: @escaping (Result<Data, Error>) -> Void) {
        
        
    }
    
}
