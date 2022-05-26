import Foundation

enum ConditionCategory: String, CaseIterable, CustomStringConvertible {
    case position = "위치"
    case period = "체크인/체크아웃"
    case price = "요금"
    case guestCount = "인원"
    
    var description: String {
        return self.rawValue
    }
}
