import Foundation

class RoomListUseCase {
    
    let searchCondition: SearchCondition
    private (set)var roomList: [Room]
    
    init(roomList: [Room],
         searchCondition: SearchCondition = SearchCondition()) {
        
        self.roomList = roomList
        self.searchCondition = searchCondition
    }
}
