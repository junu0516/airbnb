import Foundation

final class RoomPositionMapUseCase {
    
    private let roomPositionMapRepository: RoomPositionMapRepository
    private (set)var roomPositionInfoList = Observable<[RoomPositionInfo]>([])
    
    init(roomPositionMapRepository repository: RoomPositionMapRepository) {
        self.roomPositionMapRepository = repository
    }
    
    func initialize() {
        roomPositionMapRepository.fetch { [weak self] roomPositionInfoList in
            self?.roomPositionInfoList.value = roomPositionInfoList.rooms
        }
    }
}
