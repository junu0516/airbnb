import Foundation

enum HttpMethod: CustomStringConvertible {
    case get
    case post
    
    var description: String {
        switch self {
        case .get:
            return "get"
        case .post:
            return "post"
        }
    }
}
