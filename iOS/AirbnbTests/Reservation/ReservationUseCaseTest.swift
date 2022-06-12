import XCTest
@testable import Airbnb

class ReservationUseCaseTest: XCTestCase {

    private var useCase: ReservationUseCase!
    private var repository: ReservationRepository!
    private var networkManager: MockNetworkServiceManager!
    
    override func setUp(){
        super.setUp()
        
        let checkInDate = DateComponents(year: 2022, month:5, day:17)
        let checkOutDate = DateComponents(year: 2022, month:6, day:4)
        let reservation = Reservation(checkInDate: checkInDate, checkOutDate: checkOutDate, guestsCount: 3, priceForOneDay: 70358)
        
        self.networkManager = MockNetworkServiceManager()
        self.repository = ReservationRepository(networkService: networkManager, jsonHandler: JsonHandler())
        self.useCase = ReservationUseCase(reservationRepository: repository, reservation: reservation)
    }
    
    /*
       ReservationPrice 객체 배열 생성 관련 테스트
     */
    func test_generating_prices() {
        //우선 Observable<[ReservationPrice]>의 value 속성의 Nil 여부 확인
        XCTAssertNotNil(self.useCase.reservation.value)
        //빈 배열이 들어있는지 value 속성에 있는 배열 인스턴스의 길이 0 이하인지 확인
        XCTAssertLessThanOrEqual(self.useCase.reservationPrices.value.count, 0)
        
        //generateReservationPrices() 메소드 호출 후, value 속성에 있는 배열 인스턴스의 길이가 1 이상인지 확인
        let prices = self.useCase.generateReservationPrices()
        self.useCase.reservationPrices.value = prices
        XCTAssertGreaterThan(self.useCase.reservationPrices.value.count, 1)
    }
    
    /*
        예약 POST 요청 관련 테스트
     */
    
    //예약 성공을 가정하고 테스트
    func test_sending_reservation_request_success() throws {
        networkManager.shouldFail = false
        useCase.sendReservationRequest()
        
        XCTAssertNotNil(useCase.reservationResultFlag?.value)
        XCTAssertEqual(useCase.reservationResultFlag?.value, true)
    }
    
    //예약 실패를 가정하고 테스트
    func test_sending_reservation_request_failure() throws {
        networkManager.shouldFail = true
        useCase.sendReservationRequest()
        
        XCTAssertNotNil(useCase.reservationResultFlag?.value)
        XCTAssertEqual(useCase.reservationResultFlag?.value, false)
    }
    
}
