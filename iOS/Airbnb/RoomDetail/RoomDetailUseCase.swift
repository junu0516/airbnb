import Foundation

class RoomDetailUseCase {
    
    private let repository: RoomDetailRepository
    private let roomId: UniqueID
    private (set)var roomDetail: Observable<RoomDetail> = Observable<RoomDetail>(RoomDetail())
    
    private (set)var image: Observable<Data> = Observable<Data>(Data())
    private (set)var profileImage: Observable<Data> = Observable<Data>(Data())
    
    init(roomId: UniqueID, repository: RoomDetailRepository) {
        self.repository = repository
        self.roomId = roomId
    }
  
    func initializeData() {
        repository.fetch(roomId: roomId) { [weak self] responseData in
            self?.roomDetail.value = responseData
            
            // 임시로 imageUrl 배열에서 url 하나만 꺼내서 요청하도록 처리 (추후 연쇄 요청으로 수정 필요)
            self?.repository.fetchImage(imageUrl: responseData.images[0]) { [weak self] responseImage in
                self?.image.value = responseImage
            }
            
            self?.repository.fetchImage(imageUrl: responseData.profileOfHost) { [weak self] responseImage in
                self?.profileImage.value = responseImage
            }
        }
    }
}
