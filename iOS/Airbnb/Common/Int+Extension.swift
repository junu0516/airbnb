import Foundation

extension Int {
    
    func toDecimalString() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self))
    }
}
