import Foundation

final class RoomPositionMapUseCase {
    
    private let roomPositionMapRepository: RoomPositionMapRepository
    private (set)var roomPositionInfoList = Observable<[RoomPositionInfo]>([])
    
    init(roomPositionMapRepository repository: RoomPositionMapRepository) {
        self.roomPositionMapRepository = repository
    }
    
    //임시로 임의의 좌표값 부여하는 로직을 임시로 적용(추후 실서버에서 유효한 좌표값 응답하면 제거해야 함)
    func initializeData() {
        roomPositionMapRepository.fetch { [weak self] roomPositionInfoList in
            self?.roomPositionInfoList.value = addTemporaryCoordinates(roomPositionInfoList.rooms)
        }
        
        func addTemporaryCoordinates(_ list: [RoomPositionInfo]) -> [RoomPositionInfo] {
            var list = list
            var latitude = 37.485124
            var longitude = 127.0275777
            
            for index in 0..<list.count {
                list[index].latitude = latitude
                list[index].longitude = longitude
        
                latitude += 0.01
                longitude += 0.01
            }
            return list
        }
    }
}
