import Foundation

protocol JsonHandlable {
    func convertJsonToObject<T:Decodable>(from data: Data, to targetType: T.Type) -> T?
    func convertObjectToJson<T:Encodable>(from object: T) -> Data?
}

struct JsonHandler: JsonHandlable {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func convertJsonToObject<T: Decodable>(from data: Data, to targetType: T.Type) -> T? {
        return try? decoder.decode(T.self, from: data)
    }
    
    func convertObjectToJson<T: Encodable>(from object: T) -> Data? {
        return try? encoder.encode(object)
    }
}
