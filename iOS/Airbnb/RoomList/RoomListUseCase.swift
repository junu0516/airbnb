import Foundation

class RoomListUseCase {
    
    private (set)var roomList: [Room]
    
    init(roomList: [Room]) {
        self.roomList = roomList
    }
}
