import Foundation

class RoomListUseCase {
    
    private let roomList: [Room]
    
    init(roomList: [Room]) {
        self.roomList = roomList
    }
}
