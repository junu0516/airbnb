import Foundation

extension DateComponents {
    
    func toFormattedString(format: String) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let date = calendar.date(from: self) ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }

    func getDateInterval(from: DateComponents) -> Int {
        let calendar = Calendar(identifier: .gregorian)
        guard let startDate = calendar.date(from: from),
              let endDate = calendar.date(from: self) else { return 0 }

        let interval = endDate.timeIntervalSince(startDate)
        return Int(interval/86400)
    }
}
