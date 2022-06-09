import Foundation

class RoomDetailUseCase {
    
    private let repository: RoomDetailRepository
    private let roomId: UniqueID
    private (set)var roomDetail: Observable<RoomDetail> = Observable<RoomDetail>(RoomDetail())
    private (set)var profileImage: Observable<Data> = Observable<Data>(Data())
    var didSuccessResponseImage: ((Data, Int) -> Void)?
    
    let searchCondition: SearchCondition
    
    init(roomId: UniqueID,
         repository: RoomDetailRepository,
         searchCondition: SearchCondition = SearchCondition()) {
        
        self.repository = repository
        self.roomId = roomId
        self.searchCondition = searchCondition
    }
  
    func initializeData() {
        repository.fetch(roomId: roomId) { [weak self] responseData in
            self?.roomDetail.value = responseData

            for index in 0..<responseData.images.count {
                self?.repository.fetchImage(imageUrl: responseData.images[index], { [weak self] imageData in
                    self?.didSuccessResponseImage?(imageData, index)
                })
            }
            
            self?.repository.fetchImage(imageUrl: responseData.profileOfHost) { [weak self] responseImage in
                self?.profileImage.value = responseImage
            }
            
            self?.repository.fetchImage(imageUrl: responseData.profileOfHost) { [weak self] responseImage in
                self?.profileImage.value = responseImage
            }
        }
    }
}
