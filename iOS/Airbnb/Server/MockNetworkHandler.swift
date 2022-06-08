import Foundation

struct MockNetworkHandler: NetworkService {
    
    var expectSucceed: Bool = true
    
    func request(endPoint: EndPoint,
                 body: Data?,
                 completion: @escaping (Result<Data, Error>) -> Void) {
        
        
    }
}
