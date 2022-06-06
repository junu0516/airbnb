import Foundation

struct Reservation {
    
    let checkInDate: String
    let checkOutDate : String
    let guestsCount: String
    
    init() {
        self.checkInDate = "5월 17일"
        self.checkOutDate = "6월 4일"
        self.guestsCount = "게스트 3명"
    }
}
