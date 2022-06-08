import Foundation


struct RoomPosition {
    let address: String
    let placeId: String
    private let category: RoomPositionCategory // 주소가 포함된 시,군,구
    
    init(address: String) {
        self.address = address
        self.placeId = ""
        self.category = RoomPositionCategory(categoryLiteral: "서울시")
    }
    
    init(address: String, placeId: String) {
        self.address = address
        self.placeId = placeId
        self.category = RoomPositionCategory(categoryLiteral: "서울시")
    }
}
