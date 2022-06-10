import Foundation

protocol RoomDetailRepositoryProtocol {
    func fetch(roomId: UniqueID, completion: @escaping (RoomDetail) -> Void)
    func fetchImage(imageUrl: String, _ completion: @escaping (Data) -> Void)
}

