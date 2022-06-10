import XCTest
@testable import Airbnb

class RoomDetailUseCaseTest: XCTestCase {
    
    private var useCase: RoomDetailUseCase!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        guard let mockRepository = MockRoomDetailRepository(mockFileName: "roomDetail") else {
            throw XCTSkip()
        }
        self.useCase = RoomDetailUseCase(roomId: 1, repository: mockRepository)
    }

    override func tearDownWithError() throws {
        self.useCase = nil
        try super.tearDownWithError()
    }

    func testUseCase_whenInitializeData_successBindingRoomDetailEntity() throws {
        // Given
        let expectation = expectation(description: #function)
        useCase.initializeData()
        
        // When
        useCase.roomDetail.bind { data in
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testUseCase_whenInitializeData_successResponseImages() throws {
        // Given
        let expectation = expectation(description: #function)
        var imageCount = 0
        let maxImageCount = 4
        useCase.didSuccessResponseImage = { (imageData, index) in
            imageCount += 1
            if imageCount == maxImageCount {
                expectation.fulfill()
            }
        }
        
        // When
        useCase.initializeData()
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
    func testMockRepository_whenInitializeJsonFile_isSuccessfetchRoomEntity() throws {
        // Given
        let mockRepository = MockRoomDetailRepository(mockFileName: "roomDetail")
        XCTAssertNotNil(mockRepository, "Mock Repository initialize success  by Mock.json")
    
        // When
        let expectation = expectation(description: #function)
        mockRepository?.fetch(roomId: 1) { decodedEntity in
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testMockRepository_withNotExistJsonFile_failInit() throws {
        // Given
        let mockRepository = MockRoomDetailRepository(mockFileName: "Mom")
        XCTAssertNil(mockRepository, "Mock Repository initialize fail by Mom.json")
    }
}

// MARK: - MockRoomDetailRepository
class MockRoomDetailRepository: RoomDetailRepositoryProtocol {

    private (set)var room: RoomDetail?
    
    init?(mockFileName: String) {
        guard let mockData = loadMockData(fileName: mockFileName) else {
            return nil
        }
        guard let decodedData = try? JSONDecoder().decode(RoomDetail.self, from: mockData) else {
            return nil
        }
        self.room = decodedData
    }
    
    func loadMockData(fileName: String) -> Data? {
        guard let path = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print(fileName)
            return nil
        }
        guard let data: Data = try? Data(contentsOf: path) else {
            print("")
            return nil
        }
        return data
    }
    
    func fetch(roomId: UniqueID, completion: @escaping (RoomDetail) -> Void) {
        if let room = self.room {
            completion(room)
        }
    }
    
    func fetchImage(imageUrl: String, _ completion: @escaping (Data) -> Void) {
        completion(Data())
    }
}
