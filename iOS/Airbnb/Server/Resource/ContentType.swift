import Foundation

enum ContentType: CustomStringConvertible {
    case json
    case image
    
    var description: String {
        switch self {
        case .json:
            return "application/json"
        case .image:
            return "image/png"
        }
    }
}
