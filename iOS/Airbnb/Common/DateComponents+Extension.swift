import Foundation

extension DateComponents {
    
    func toMonthAndDayString() -> String {
        return "\(self.month ?? 0)월 \(self.day ?? 0)일"
    }
    
    func getDateInterval(from: DateComponents) -> Int {
        let calendar = Calendar(identifier: .gregorian)
        guard let startDate = calendar.date(from: from),
              let endDate = calendar.date(from: self) else { return 0 }

        let interval = endDate.timeIntervalSince(startDate)
        return Int(interval/86400)
    }
}
