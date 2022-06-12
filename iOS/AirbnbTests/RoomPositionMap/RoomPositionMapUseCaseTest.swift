import XCTest
@testable import Airbnb

class RoomPositionMapUseCaseTest: XCTestCase {
    
    private var useCase: RoomPositionMapUseCase!
    private var repository: RoomPositionMapRepository!
    private var networkManager: MockNetworkServiceManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        self.networkManager = MockNetworkServiceManager()
        self.repository = RoomPositionMapRepository(networkService: networkManager, converter: CustomConverter())
        self.useCase = RoomPositionMapUseCase(roomPositionMapRepository: repository)
    }
    
    /*
        초기 데이터 불러오는 로직 검증 - 네트워크 통신에 성공한 상황을 가정
     */
    func test_initializing_data_success() {
        
        self.networkManager.shouldFail = false

        // 미리 MockResponse로 사용할 json 데이터를 준비
        self.networkManager.loadMockData(mockData: .roomList)
        XCTAssertNotNil(self.networkManager.mockResponseData)

        //초기 데이터 배열(roomPositionInfoList.value)의 크기가 0인지 먼저 확인
        XCTAssertNotNil(useCase.roomPositionInfoList.value)
        XCTAssertLessThan(useCase.roomPositionInfoList.value.count, 1)
        
        //MockNetworkServiceManager을 통해 UseCase 내부에 데이터를 저장
        useCase.initializeData()
        
        //정상적으로 데이터 저장되었는 지, 배열의 크기가 0보다 큰 지 여부를 통해 확인
        XCTAssertGreaterThan(useCase.roomPositionInfoList.value.count, 0)
    }
    
    func test_initializing_data_failure() {
        
        self.networkManager.shouldFail = true

        // 미리 MockResponse로 사용할 json 데이터를 준비
        self.networkManager.loadMockData(mockData: .roomList)
        XCTAssertNotNil(self.networkManager.mockResponseData)

        //초기 데이터 배열(roomPositionInfoList.value)의 크기가 0인지 먼저 확인
        XCTAssertNotNil(useCase.roomPositionInfoList.value)
        XCTAssertLessThan(useCase.roomPositionInfoList.value.count, 1)
        
        //MockNetworkServiceManager을 통해 UseCase 내부에 데이터를 저장
        useCase.initializeData()
        
        //응답이 실패한 경우기 때문에, 데이터를 불러오더라도 배열의 크기가 0이어야 함
        XCTAssertLessThan(useCase.roomPositionInfoList.value.count, 1)
    }

}
