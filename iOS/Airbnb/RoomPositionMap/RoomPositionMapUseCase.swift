import Foundation

final class RoomPositionMapUseCase {
    
    private let roomPositionMapRepository: RoomPositionMapRepository
    private var roomPositionInfoList: [RoomPositionInfo] = []
    
    init(roomPositionMapRepository repository: RoomPositionMapRepository) {
        self.roomPositionMapRepository = repository
    }
    
    func initialize() {
        roomPositionMapRepository.fetch { [weak self] roomPositionInfo in
            self?.roomPositionInfoList.append(roomPositionInfo)
        }
    }
}
