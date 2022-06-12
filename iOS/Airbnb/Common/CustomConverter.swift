import Foundation

protocol ObjectConvertible {
    func convertJsonToObject<T:Decodable>(from data: Data, to targetType: T.Type) -> T?
    func convertObjectToJson<T:Encodable>(from object: T) -> Data?
    func convertObjectToDictionary<T: Encodable>(from object: T) -> [String:Any]?
    func convertJsonToDictionary(from data: Data) -> [String:Any]?
}

struct CustomConverter: ObjectConvertible {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func convertJsonToObject<T: Decodable>(from data: Data, to targetType: T.Type) -> T? {
        return try? decoder.decode(T.self, from: data)
    }
    
    func convertObjectToJson<T: Encodable>(from object: T) -> Data? {
        return try? encoder.encode(object)
    }
    
    func convertObjectToDictionary<T: Encodable>(from object: T) -> [String:Any]? {
        guard let jsonData = self.convertObjectToJson(from: object) else { return nil}
        guard let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: .fragmentsAllowed) as? [String:Any] else { return nil }
        return dictionary
    }
    
    func convertJsonToDictionary(from data: Data) -> [String : Any]? {
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String:Any] else { return nil }
        return dictionary
    }
}
