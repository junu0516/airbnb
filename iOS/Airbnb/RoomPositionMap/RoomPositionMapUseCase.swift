import Foundation

final class RoomPositionMapUseCase {
    
    private let roomPositionMapRepository: RoomPositionMapRepository
    private (set)var roomPositionInfoList = Observable<[RoomPositionInfo]>([])
    
    init(roomPositionMapRepository repository: RoomPositionMapRepository) {
        self.roomPositionMapRepository = repository
    }
    
    //임시로 임의의 좌표값 부여하는 로직을 임시로 적용(추후 실서버 붙였을 때 제거해야 함)
    func initialize() {
        roomPositionMapRepository.fetch { [weak self] roomPositionInfoList in
            var roomPositionInfoList = roomPositionInfoList
            roomPositionInfoList.rooms[0].latitude = 37.485124
            roomPositionInfoList.rooms[0].longitude = 127.0275777
            roomPositionInfoList.rooms[1].latitude = 37.490864
            roomPositionInfoList.rooms[1].longitude = 127.033406
            self?.roomPositionInfoList.value = roomPositionInfoList.rooms
        }
    }
}
