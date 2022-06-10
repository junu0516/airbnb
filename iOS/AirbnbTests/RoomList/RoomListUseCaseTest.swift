import XCTest
@testable import Airbnb

class RoomListUseCaseTest: XCTestCase {

    func testUseCase_whenGenerateData_correctCount() throws {
        let generateDatacount = 5
        let roomList = RoomListFactory.generate(count: generateDatacount)
        let useCase = RoomListUseCase(roomList: roomList)
        XCTAssertEqual(useCase.roomList.count, generateDatacount, "Correct count generated rooms")
    }
    
    func testUseCase_whenGenerateData_notMatchCount() throws {
        let generateDatacount = 5
        let roomList = RoomListFactory.generate(count: generateDatacount)
        let useCase = RoomListUseCase(roomList: roomList)
        XCTAssertNotEqual(useCase.roomList.count, 1, "Does not match count generated rooms")
    }
}

// MARK: - RoomListFactory
struct RoomListFactory {
    static func generate(count: Int) -> [Room] {
        var results: [Room] = []
        for i in 0..<count {
            results.append(
                Room(roomId: i, roomName: "name \(i)", thumbnailImage: "", pricePerDay: i * 1000, totalPrice: i * 10000, isWished: false, averageOfStar: 0.0, numberOfReviews: 0)
            )
        }
        return results
    }
}
