import Foundation

enum ContentType {
    case json
    case image
    var value: String {
        switch self {
        case .json:
            return "application/json"
        case .image:
            return "image/png"
        }
    }
}
